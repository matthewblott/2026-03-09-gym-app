class NotesController < ApplicationController
  include Pagy::Method

  def index
    @pagy, @notes = pagy(Note.recent_first, items: 20)
    if turbo_frame_request?
      render partial: "notes/notes_frame", locals: { note_view_models: @notes, pagy: @pagy }
    else
      render :index
    end
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    if @note.save
      AlertBroadcaster.broadcast(Current.user.id, "Note was successfully created.", type: :success)
    else
      render :new, status: :unprocessable_content
    end

  end

  def destroy_multiple
    @deleted_ids = Array(params[:ids])
    Note.where(id: params[:ids]).destroy_all

    @deleted_ids.each do |id|
    end
    
    AlertBroadcaster.broadcast(Current.user.id, "Note(s) successfully deleted.", type: :danger)
  end

  private

  def set_note
    @note = Note.find(params.expect(:id))
  end

  def note_params
    params.expect(note: [ :img ])
  end
end
