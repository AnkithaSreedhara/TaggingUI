### Take Home Assignemnt: A tagging UI

![iOS interview design](https://user-images.githubusercontent.com/1269263/91380618-b76f7800-e868-11ea-8e14-0dc2dc75f8a3.png)

You don't need to follow the exactly same UI design above, but it is important to implement the functionalities in the specs below.

Specs:
1. User can enter tag from the bottom input box and add it into tags view above.
2. The input box stays above the keyboard while user entering text.
3. Persist the state locally, so the app can restore its state after reopen, JSON is preferred persistent format.
4. Add a remove button on the tag as shown in the screenshot, so user can remove it from the screen; removing tag triggers an animation for the tags after to take over the position.
5. User can drag and drop the tags to reposition the sequence; while user dragging the tag, the rest of tags reposition themselves with animation to leave space for the dragged tag.

Requirements:
1. You can use swift or objective c; no third paty library
2. Object-oriented solution, modular design.
3. Business logic is separated from UI.
4. Automated testing is not required, but ideally the code particularly business logic is testable.
5. Please write the solution in a git repository, and email zipped git repo back.
