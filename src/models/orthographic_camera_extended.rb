class OrthographicCameraExtended < OrthographicCamera
  MOVEMENT_SPEED = 200

  include CameraInput

  def initialize
    initialize_input
  end
end