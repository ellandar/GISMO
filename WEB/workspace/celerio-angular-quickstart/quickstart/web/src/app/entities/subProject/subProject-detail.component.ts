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
import {SubProject} from './subProject';
import {SubProjectService} from './subProject.service';

@Component({
    moduleId: module.id,
	templateUrl: 'subProject-detail.component.html',
	selector: 'subProject-detail',
})
export class SubProjectDetailComponent implements OnInit, OnDestroy {
    subProject : SubProject;

    private params_subscription: any;


    @Input() sub : boolean = false;
    @Output() onSaveClicked = new EventEmitter<SubProject>();
    @Output() onCancelClicked = new EventEmitter();

    constructor(private route: ActivatedRoute, private router: Router, private messageService: MessageService, private subProjectService: SubProjectService) {
    }

    ngOnInit() {
        if (this.sub) {
            return;
        }

        this.params_subscription = this.route.params.subscribe(params => {
            let id = params['id'];
            console.log('ngOnInit for subProject-detail ' + id);

            if (id === 'new') {
                this.subProject = new SubProject();
            } else {
                this.subProjectService.getSubProject(id)
                    .subscribe(subProject => {
                            this.subProject = subProject;
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
        this.subProjectService.update(this.subProject).
            subscribe(
                subProject => {
                    this.subProject = subProject;
                    if (this.sub) {
                        this.onSaveClicked.emit(this.subProject);
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
