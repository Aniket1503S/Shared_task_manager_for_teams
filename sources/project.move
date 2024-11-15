module MyModule::TeamTaskManager {
    use aptos_framework::signer;
    use aptos_framework::account;

    struct Task has key {
        owner: address,
        description: vector<u8>,
        completed: bool,
    }

    public fun create_task(
        creator: &signer,
        description: vector<u8>,
    ) {
        let task = Task {
            owner: signer::address_of(creator),
            description,
            completed: false,
        };
        move_to(creator, task);
    }

    public fun complete_task(
        completer: &signer,
        task_owner: address,
    ) acquires Task {
        let task = borrow_global_mut<Task>(task_owner);
        assert!(signer::address_of(completer) == task.owner, 0);
        task.completed = true;
    }
}