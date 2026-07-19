from pydantic import BaseModel


class PracticeResultResponse(BaseModel):

    score: int

    total_questions: int

    percentage: float

    time_taken: int

    correct_answers: int

    wrong_answers: int