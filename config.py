from sqlalchemy import true


class Developmentconfig():
    DEBUG = true()

config = {
    'develop':Developmentconfig(),
}