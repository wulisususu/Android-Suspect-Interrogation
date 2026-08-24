class ALSARecorder:
    """Linux ALSA recorder implementation placeholder."""

    def __init__(self, device='default'):
        self.device = device
        self.running = False

    def start(self):
        self.running = True

    def stop(self):
        self.running = False
