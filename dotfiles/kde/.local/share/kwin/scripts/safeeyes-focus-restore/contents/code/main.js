let previousWindow = null;
let restorePending = false;

function isSafeEyes(window) {
    return window.resourceClass.toLowerCase().includes("safeeyes");
}

workspace.windowAdded.connect(window => {
    if (!isSafeEyes(window) || previousWindow) {
        return;
    }
    const active = workspace.activeWindow;
    if (active && !isSafeEyes(active)) {
        previousWindow = active;
    }
});

workspace.windowRemoved.connect(window => {
    if (window === previousWindow) {
        previousWindow = null;
        restorePending = false;
        return;
    }
    if (!previousWindow || !isSafeEyes(window)) {
        return;
    }
    if (workspace.windowList().some(other => other !== window && isSafeEyes(other))) {
        return;
    }
    restorePending = true;
    workspace.activeWindow = previousWindow;
});

workspace.windowActivated.connect(window => {
    if (!restorePending || !window || isSafeEyes(window)) {
        return;
    }
    restorePending = false;
    if (window !== previousWindow) {
        workspace.activeWindow = previousWindow;
    }
    previousWindow = null;
});
