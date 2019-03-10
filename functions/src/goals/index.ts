import * as functions from "firebase-functions";

export const createGoalAction = functions.firestore
  .document("goals/{goalId}/actions/{actionId}")
  .onCreate(snap => {
    const goal = snap.ref.parent.parent as FirebaseFirestore.DocumentReference;

    goal.firestore.runTransaction(async (tx: FirebaseFirestore.Transaction) => {
      const goalSnap = await tx.get(goal);
      const data = goalSnap.data();

      if (!data) return;

      const numberOfActions = (data.numberOfActions || 0) + 1;
      await tx.update(goal, { numberOfActions });
    });
  });

export const toogleGoalActionDone = functions.firestore
  .document("goals/{goalId}/actions/{actionId}")
  .onUpdate(change => {
    if (change.after && change.before) {
      const newValue = change.after.data();
      const oldValue = change.before.data();

      if (!newValue || !oldValue) return;
      if (newValue.isDone === oldValue.isDone) return;

      const goal = change.after.ref.parent
        .parent as FirebaseFirestore.DocumentReference;

      goal.firestore.runTransaction(
        async (tx: FirebaseFirestore.Transaction) => {
          const goalSnap = await tx.get(goal);
          const data = goalSnap.data();

          if (!data) return;

          const numberOfDoneActions =
            (data.numberOfDoneActions || 0) + (newValue.isDone ? 1 : -1);
          await tx.update(goal, { numberOfDoneActions });
        }
      );
    }
  });
