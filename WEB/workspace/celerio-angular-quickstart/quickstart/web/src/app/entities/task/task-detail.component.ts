//
// Source code generated by Celerio, a Jaxio product.
// Documentation: http://www.jaxio.com/documentation/celerio/
// Follow us on twitter: @jaxiosoft
// Need commercial support ? Contact us: info@jaxio.com
// Template pack-angular:web/src/app/entities/entity-detail.component.ts.e.vm
//
import {Component, OnInit, OnDestroy, Input, Output, EventEmitter} from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { SelectItem } from 'primeng/primeng';
import { MessageService} from '../../service/message.service';
import {Task} from './task';
import {TaskService} from './task.service';

@Component({
    moduleId: module.id,
	templateUrl: 'task-detail.component.html',
	selector: 'task-detail',
})
export class TaskDetailComponent implements OnInit, OnDestroy {
    task : Task;

    private params_subscription: any;


    @Input() sub : boolean = false;
    @Output() onSaveClicked = new EventEmitter<Task>();
    @Output() onCancelClicked = new EventEmitter();
    levelOptions: SelectItem[];
    stateOptions: SelectItem[];

    constructor(private route: ActivatedRoute, private router: Router, private messageService: MessageService, private taskService: TaskService) {
        this.levelOptions = [];
        this.levelOptions.push({"label": "Simple", 'value': "Simple"});
        this.levelOptions.push({"label": "Complexe", 'value': "Complexe"});
        this.stateOptions = [];
        this.stateOptions.push({"label": "Ouverte", 'value': "OPEN"});
        this.stateOptions.push({"label": "En cours", 'value': "IN_PROGRESS"});
        this.stateOptions.push({"label": "Livrée", 'value': "DELIVERED"});
        this.stateOptions.push({"label": "Close", 'value': "CLOSED"});
    }

    ngOnInit() {
        if (this.sub) {
            return;
        }

        this.params_subscription = this.route.params.subscribe(params => {
            let id = params['id'];
            console.log('ngOnInit for task-detail ' + id);

            if (id === 'new') {
                this.task = new Task();
            } else {
                this.taskService.getTask(id)
                    .subscribe(task => {
                            this.task = task;
                        },
                        error =>  this.messageService.error('ngOnInit error', error)
                    );
            }
        });
    }

    ngOnDestroy() {
        if (!this.sub) {
            this.params_subscription.unsubscribe();
        }
    }

    onSave() {
        this.taskService.update(this.task).
            subscribe(
                task => {
                    this.task = task;
                    if (this.sub) {
                        this.onSaveClicked.emit(this.task);
                        this.messageService.info('Saved OK and msg emitted', 'Angular Rocks!')
                    } else {
                        this.messageService.info('Saved OK', 'Angular Rocks!')
                    }
                },
                error =>  this.messageService.error('Could not save', error)
            );
    }

    onCancel() {
        if (this.sub) {
            this.onCancelClicked.emit("cancel");
            this.messageService.info('Cancel clicked and msg emitted', 'Angular Rocks!')
        }
    }

}