struct SessionPulseEvent: AppEvent {
    let seconds: Int
}


struct SessionFinishEvent: AppEvent {
    let timePassed: Int
    let type: SessionType
}
