from pydantic import BaseModel


class PracticeQuestion(BaseModel):

    word: str

    options: list[str]

    correct_answer: str


class PracticeSubmit(BaseModel):

    user_id: int

    language_id: int

    score: int

    total_questions: int

    time_taken: int


class PracticeDashboard(BaseModel):

    tests_taken: int

    best_score: int

    last_score: int

    average_score: float