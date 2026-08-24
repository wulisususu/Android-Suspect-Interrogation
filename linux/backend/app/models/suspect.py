from dataclasses import dataclass


@dataclass
class Suspect:
    suspect_id: str
    case_id: str
    name: str | None = None
    id_number: str | None = None
