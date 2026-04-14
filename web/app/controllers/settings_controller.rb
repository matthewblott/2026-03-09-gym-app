class SettingsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :authorize_user!

  def send_code
    email = params[:email]

    if User.exists?(email: email)
      flash.now[:alert] = 'An account with that email already exists.'
      render :new, status: :unprocessable_entity and return
    end

    generate_and_send_otp(email)
    redirect_to settings_verify_code_path
  end

  def verify
    @email = session[:email]
    redirect_to settings_path if @email.blank?
  end

  def create
    otp_secret = session[:otp_secret]
    email = session[:email]

    redirect_to settings_path and return if otp_secret.blank? || email.blank?

    unless verify_otp_code(otp_secret, params[:otp_code])
      flash.now[:alert] = 'Invalid or expired code.'
      @email = email
      render :verify, status: :unprocessable_entity and return
    end

    user = User.find(Current.user.id)
    user.update!(
      email: email,
      otp_secret: otp_secret,
      otp_enabled: true
    )

    cookies.delete(:device_token)

    new_session = user.sessions.create!
    set_session_cookie(new_session)
    Current.session = new_session
    Current.user = user

    redirect_to workouts_path(user), notice: 'Account updated. You can now sign in from any device.'
  end
  
  private

  def generate_and_send_otp(email)
    otp_secret = ROTP::Base32.random_base32
    otp_code = ROTP::TOTP.new(otp_secret, issuer: "MyApp").now

    session[:otp_secret] = otp_secret
    session[:email] = email

    UserMailer.with(email:, otp_code:).send_otp.deliver_now

    otp_secret
  end

  def send_otp(user)
    otp_code = user.otp.now
    session[:email] = user.email
    UserMailer.with(email: user.email, otp_code:).send_otp.deliver_now
  end

  def verify_otp_code(otp_secret, code)
    ROTP::TOTP.new(otp_secret, issuer: "MyApp").verify(code, drift_behind: 30)
  end

  def set_session_cookie(new_session)
    cookies.signed.permanent[:session_token] = {
      value: new_session.id,
      httponly: true,
      secure: Rails.env.production?,
      same_site: :lax
    }
  end

end
