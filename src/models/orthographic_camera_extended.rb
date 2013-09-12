class OrthographicCameraExtended < OrthographicCamera
  MOVEMENT_SPEED = 200

  include CameraInputTranslator

  def initialize
    initialize_input
  end
end