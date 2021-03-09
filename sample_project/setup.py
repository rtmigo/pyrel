from setuptools import setup, find_packages

# we need to add some meta-data so [twine check] will complete without warnings

setup(
    name="greeter",
    version="0.0.1",
    author="John Smith",
    description="Sample package",

    packages=find_packages(),
    install_requires=[],

    long_description="This package helps to test pyrel functionalities.",
    long_description_content_type='text/markdown',

    entry_points={
        'console_scripts': [
            f'greeter = greeter:say_hi',
        ]},

    keywords="apps python packages deployment".split(),

    classifiers=[
        "Development Status :: 2 - Pre-Alpha",
        "Intended Audience :: Developers",
        "Operating System :: POSIX",
    ],
)
