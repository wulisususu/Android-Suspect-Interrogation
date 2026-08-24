class MockIDCardReader:
    """Development fallback when no physical reader exists."""

    def read(self):
        return {
            "status": "success",
            "name": "test-user",
            "id_number": "000000000000000000"
        }
