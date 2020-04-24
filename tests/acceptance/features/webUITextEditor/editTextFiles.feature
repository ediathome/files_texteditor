@webUI @insulated
Feature: textFiles

  Background:
    Given these users have been created with skeleton files:
      | username |
      | user1    |
    And user "user1" has logged in using the webUI
    And the user has browsed to the files page

  Scenario: Edit a text file with the default name and file extension in a sub-folder
    When the user opens folder "simple-folder" using the webUI
    And the user creates a text file with the name "" using the webUI
    And the user inputs "stuff" in the text area
    And the user closes the text editor
    Then file "New text file.txt" should be listed on the webUI
    And the user reloads the current page of the webUI
    Then file "New text file.txt" should be listed on the webUI
    And the user opens file "New text file.txt" using the webUI
    Then line 1 of the text should be "stuff"
    And the user inputs "other text before " in the text area
    And the user closes the text editor
    And the user opens file "New text file.txt" using the webUI
    Then line 1 of the text should be "other text before stuff"

  @issue-36233
  Scenario: Delete and restore hidden text file
    Given the user has created a text file with the name "abc.txt"
    And the user has input "This is a hidden file" in the text area
    And the user has closed the text editor
    When the user enables the setting to view hidden files on the webUI
    And the user renames file "abc.txt" to ".abc.txt" using the webUI
    And the user deletes file ".abc.txt" using the webUI
    Then file ".abc.txt" should be listed in the trashbin on the webUI
    When the user restores file ".abc.txt" from the trashbin using the webUI
    And the user browses to the files page
    Then file ".abc.txt" should be listed on the webUI
    When the user opens file ".abc.txt" using the webUI
#    Then line 1 of the text should be "This is a hidden file"
