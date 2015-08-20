require 'kml'
require 'gruff'

class TracksController < ApplicationController
  before_action :set_track, only: [:show, :edit, :update, :destroy]

  # GET /tracks
  # GET /tracks.json
  def index
    @tracks = Track.all

    @new_tracks = []
    Dir['data/*.kml'].each do |file|
      @new_tracks << KML.new(file)
    end
    #@track_data = Track.track_from_kml(File.read(Rails.root.join("data/test.kml")))
    @track_data = []
  end

  # GET /tracks/1
  # GET /tracks/1.json
  def show
    @altitude_file = "graphs/#{@track.id}-altitude.png"
    @altitude_thumbnail_file = "graphs/#{@track.id}-altitude-thumbnail.png"
    altitude_path = File.expand_path("images/#{@altitude_file}", Rails.public_path)
    altitude_thumbnail_path = File.expand_path("images/#{@altitude_thumbnail_file}", Rails.public_path)
    if ! (File.exists?(altitude_path) and File.exists?(altitude_thumbnail_path))
      image = Gruff::Line.new
      image.title = 'Altitude'
      t_start = Time.parse(@track.nodes.first.time.to_s).to_i
      puts "Start: #{@track.nodes.first.inspect}"
      puts "End: #{@track.nodes.last.inspect}"
      t_range = Time.parse(@track.nodes.last.time.to_s).to_i - t_start
      image.dataxy('Altitude', @track.nodes.map{ |n| [Time.parse(n.time.to_s).to_i - t_start, n.alt] })
      (t_range/3600 + 1).times do |i|
        image.labels[i*3600] = "#{i}"
      end
      image.x_axis_label = 'Hours'
      image.y_axis_label = 'Meters'
      image.minimum_value = 0
      image.write(altitude_path)
      image.resize(0.5)
      image.write(altitude_thumbnail_path)
    end
  end

  # GET /tracks/new
  def new
    @track = Track.new
  end

  # GET /tracks/1/edit
  def edit
  end

  # POST /tracks
  # POST /tracks.json
  def create
    @track = Track.new(track_params)

    respond_to do |format|
      if @track.save
        if @nodes
          @nodes.each do |node_data|
            node_data['track'] = @track
            Node.create(node_data)
          end
        end
        format.html { redirect_to @track, notice: 'Track was successfully created.' }
        format.json { render :show, status: :created, location: @track }
      else
        format.html { render :new }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tracks/1
  # PATCH/PUT /tracks/1.json
  def update
    respond_to do |format|
      if @track.update(track_params)
        format.html { redirect_to @track, notice: 'Track was successfully updated.' }
        format.json { render :show, status: :ok, location: @track }
      else
        format.html { render :edit }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tracks/1
  # DELETE /tracks/1.json
  def destroy
    @track.destroy
    respond_to do |format|
      format.html { redirect_to tracks_url, notice: 'Track was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    track_data = KML.new(params[:file])
    params[:track] = {title: track_data.name}
    @nodes = track_data.nodes
    self.create
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_track
      @track = Track.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def track_params
      params.require(:track).permit(:title)
    end
end
