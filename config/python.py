from typing import List


dev_requires: List[str] = [
]
config_requires: List[str] = [
]
install_requires: List[str] = [
]
build_requires: List[str] = [
    "pymakehelper",
    "pydmt",
]
test_requires: List[str] = [
]
requires = config_requires + install_requires + build_requires + test_requires
