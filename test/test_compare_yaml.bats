#!/usr/bin/env bats


load 'libs/bats-support/load'
load 'libs/bats-assert/load'

@test "Compare specific nested lines in YAML files" {
  # Define the paths to the YAML files
  local file1="/mnt/c/Users/nomul/bats-core-test/file1.yaml"
  local file2="/mnt/c/Users/nomul/bats-core-test/file2.yaml"

  # Extract the 'apples' block using yq and compare them using diff
  #local path=".nested.vegetables"

 # Extract the 'apples' section
  apples1=$(yq eval '.apples' "$file1")
  apples2=$(yq eval '.apples' "$file2")

  # Extract the 'nested.fruits' section
  fruits1=$(yq eval '.nested.fruits' "$file1")
  fruits2=$(yq eval '.nested.fruits' "$file2")

  # Compare the extracted sections
  run diff <(echo "$apples1"$'\n'"$fruits1") <(echo "$apples2"$'\n'"$fruits2")
  
  # Assert that the command was successful, meaning no differences were found
  assert_success "The specified nested lines in 'apples' and 'nested.fruits' are identical."

  # Optionally, check for specific output if needed (e.g., expected differences)
  assert_output ""
}
