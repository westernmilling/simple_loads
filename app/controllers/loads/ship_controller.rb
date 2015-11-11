class Loads::ShipController < ApplicationController
  def edit
    render_edit
  end

  def update
    render_edit and return unless entry.valid?

    if ship_load
      redirect_to load_path(load), notice: t('.success')
    else
      flash[:alert] = t('.failure')

      render_edit
    end
  end

  private

  def render_edit
    render :edit, locals: { entry: entry, load: load }
  end

  def entry
    @entry ||= build_entry
  end

  def build_entry
    ShipLoadEntry.new(entry_params)
  end

  def load
    Load.find(params[:load_id])
  end

  def ship_load
    ShipLoad.new(load).ship(entry)
  end

  def entry_params
    return {} if params[:entry].nil? || params[:entry].empty?

    params
      .require(:entry)
      .permit(:ship_date,
              :weight_gross,
              :weight_net,
              :weight_tare)
  end
end
