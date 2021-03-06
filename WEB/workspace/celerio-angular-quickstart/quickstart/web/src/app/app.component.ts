//
// Source code generated by Celerio, a Jaxio product.
// Documentation: http://www.jaxio.com/documentation/celerio/
// Follow us on twitter: @jaxiosoft
// Need commercial support ? Contact us: info@jaxio.com
// Template pack-angular:web/src/app/app.component.ts.p.vm
//
import { Component,OnInit } from '@angular/core';
import { RouterModule } from '@angular/router';
import { Observable } from 'rxjs/Observable';
import 'rxjs/add/observable/throw';
import { Message, MenuItem } from 'primeng/primeng';
import { AuthService} from './service/auth.service';
import { MessageService} from './service/message.service';

/**
 * The Root component.
 * Defines the main layout and handles user login in a dialog.
 */
@Component({
    moduleId: module.id,
    selector: 'app-root',
    template: `
        <p-growl [value]="msgs"></p-growl>

        <div class="ui-g layout">
            <div class="ui-g-12 ui-md-11 ui-g-nopad">
                <div class="ui-g-12 ui-g-nopad" style="font-size: 14px;">
                    <p-menubar [model]="items"></p-menubar>
                </div>
                <div class="ui-g-12">
                    <router-outlet></router-outlet>
                </div>
            </div>
        </div>
        <p-dialog header="Please login" [visible]="displayLoginDialog" [responsive]="true" showEffect="fade" [modal]="true" [closable]="false" *ngIf="!authenticated">
            <p>When using the sample database, use admin/admin</p>
            <div ngForm class="ui-g">
                <div class="ui-g-12" *ngIf="loginFailed">
                    <div class="ui-message ui-messages-error ui-corner-all">
                        Invalid login or password
                    </div>
                </div>
                <div class="ui-g-12">
                    <div class="ui-g-4">
                        <label for="j_username">Username</label>
                    </div>
                    <div class="ui-g-8">
                        <input pInputText id="j_username" [(ngModel)]="j_username" name="username"/>
                    </div>
                </div>
                <div class="ui-g-12">
                    <div class="ui-g-4">
                        <label for="j_password">Password</label>
                    </div>
                    <div class="ui-g-8">
                        <input type="password" pPassword id="j_password" [(ngModel)]="j_password" name="password"/>
                    </div>
                </div>
            </div>
            <footer>
                <div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix">
                    <button pButton (click)="login()" icon="fa-sign-in" label="Login"></button>
                </div>
            </footer>
        </p-dialog>
               `,
    styles:[`
        .layout div {
            background-color: white;
            border: 1px solid #f5f7f8;
        }
    `]
})
export class AppComponent implements OnInit {
    public items : MenuItem[] = [{label: 'hello'}];
    msgs : Message[] = [];

    displayLoginDialog : boolean = false;
    loginFailed : boolean = false;
    authenticated : boolean = false;
    j_username : string = "admin";
    j_password : string = "admin";

    constructor(private authService: AuthService, private messageService: MessageService) {
        messageService.messageSource$.subscribe(
            msg => {
                this.msgs.push(msg);
            });
    }

    ngOnInit() {
        this.items = [
            { label: 'Home', routerLink: ['/'], icon: 'fa-home' },

            { label: 'Tasks', icon: 'fa-search', items: [
                    {label: 'Imputation GISMO', routerLink: ['/gismoImputation-list']},
                    {label: 'Liste des taches', routerLink: ['/task-list']},
                    {label: 'Lien entre taches', routerLink: ['/taskLink-list']},
                    {label: 'Liste des types de taches', routerLink: ['/taskType-list']} ]
            },
            { label: 'Export', icon: 'fa-search', items: [
                    {label: 'Imputation GISMO', routerLink: ['/gismoImputation-list']},
                    {label: 'Liste des taches', routerLink: ['/task-list']},
                    {label: 'Lien entre taches', routerLink: ['/taskLink-list']},
                    {label: 'Liste des types de taches', routerLink: ['/taskType-list']} ]
            },
			{ label: 'Plugin', icon: 'fa-search', items: [
				{ label: 'CAPITAL', icon: 'fa-search', items: [
						{label: 'Imputation CAPITAL', routerLink: ['/capitalImputation-list']},
						{label: 'Liste des OS CAPITAL', routerLink: ['/capitalOs-list']},
						{label: 'Liste des Items CAPITAL', routerLink: ['/capitalItem-list']},
						{label: 'Liste des types CAPITAL', routerLink: ['/capitalSubtype-list']} ]
				},
				{ label: 'JIRA', icon: 'fa-search', items: [					
						{label: 'Liste des taches JIRA', routerLink: ['/jiraTask-list']},
						{label: 'Liste des états JIRA', routerLink: ['/jiraStates-list']},
						{label: 'Liste des types JIRA', routerLink: ['/jiraTaskType-list']}               ]
				}]
			},
            { label: 'Paramétrage', icon: 'fa-search', items: [
				{ label: 'Affaires', icon: 'fa-search', items: [
						{label: 'Liste des clients et groupes', routerLink: ['/projectGroup-list']},
						{label: 'Liste des Projects', routerLink: ['/project-list']},
						{label: 'Liste des Versions', routerLink: ['/version-list']},
						{label: 'Liste des sous projets', routerLink: ['/subProject-list']},
						{label: 'Liste des sous version', routerLink: ['/subVersion-list']}             ]
				},
				{ label: 'Utilisateurs', icon: 'fa-search', items: [
						{label: 'Liste des utilisateurs', routerLink: ['/gismoUser-list']},
						{label: 'Liste des profils', routerLink: ['/profil-list']}                          ]
				},
				{ label: 'Paramétrage date', icon: 'fa-search', items: [
						{label: 'Liste des semaines', routerLink: ['/weekNumber-list']}               ]
				}   ]
			}
        ];

        this.authService.isAuthenticated().
            subscribe(
                resp =>
                    {
                        this.authenticated = resp;
                        this.displayLoginDialog = !this.authenticated;
                        if (this.authenticated) {
                            this.items.push({label: 'Sign out', url: '/api/logout', icon: 'fa-sign-out' });
                            console.log('You are authenticated...', '');
                        } else {
                            console.log('You are NOT authenticated...', '');
                        }
                    },
                error =>  this.messageService.error('isAuthenticated Error', error)
            );
    }

    login() {
        this.authService.login(this.j_username, this.j_password).
            subscribe(
                loginOk => {
                    if (loginOk) {
                        this.displayLoginDialog = false;
                        this.authenticated = true;
                        this.items.push({label: 'Sign out', url: '/api/logout', icon: 'fa-sign-out' });
                        this.loginFailed = false;
                        this.messageService.info('You are now logged in.', '');
                    } else {
                        this.loginFailed = true;
                        this.displayLoginDialog = true;
                        this.authenticated = false;
                    }
                },
                error => {
                    this.messageService.error('Login error', error);
                    this.loginFailed = true;
                    this.displayLoginDialog = true;
                    this.authenticated = false;
                }
        );
    }
}
