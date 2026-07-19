from pydantic import BaseModel


class AnswerRequest(BaseModel):

    word_id: int

    selected_answer: str


class PracticeSubmitRequest(BaseModel):

    language_id: int

    time_taken: int

    answers: list[AnswerRequest]