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
import {Profil} from './profil';
import {ProfilService} from './profil.service';

@Component({
    moduleId: module.id,
	templateUrl: 'profil-detail.component.html',
	selector: 'profil-detail',
})
export class ProfilDetailComponent implements OnInit, OnDestroy {
    profil : Profil;

    private params_subscription: any;


    @Input() sub : boolean = false;
    @Output() onSaveClicked = new EventEmitter<Profil>();
    @Output() onCancelClicked = new EventEmitter();
    typeOptions: SelectItem[];

    constructor(private route: ActivatedRoute, private router: Router, private messageService: MessageService, private profilService: ProfilService) {
        this.typeOptions = [];
        this.typeOptions.push({"label": "Utilisateur", 'value': "USER"});
        this.typeOptions.push({"label": "Administrateur", 'value': "ADMIN"});
        this.typeOptions.push({"label": "Chef de Projet", 'value': "CDP"});
    }

    ngOnInit() {
        if (this.sub) {
            return;
        }

        this.params_subscription = this.route.params.subscribe(params => {
            let id = params['id'];
            console.log('ngOnInit for profil-detail ' + id);

            if (id === 'new') {
                this.profil = new Profil();
            } else {
                this.profilService.getProfil(id)
                    .subscribe(profil => {
                            this.profil = profil;
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
        this.profilService.update(this.profil).
            subscribe(
                profil => {
                    this.profil = profil;
                    if (this.sub) {
                        this.onSaveClicked.emit(this.profil);
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