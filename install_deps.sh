#!/usr/bin/env bash
git clone https://github.com/osscameroon/broken_link_checker.git
cd broken_link_checker
git checkout patch
pip install -r requirements.txt
