//
// Source code generated by Celerio, a Jaxio product.
// Documentation: http://www.jaxio.com/documentation/celerio/
// Follow us on twitter: @jaxiosoft
// Need commercial support ? Contact us: info@jaxio.com
// Template pack-angular:web/src/app/entities/entity-list.component.ts.e.vm
//
import { Component, Input, Output, OnChanges, EventEmitter, SimpleChanges} from '@angular/core';
import { Router } from '@angular/router';
import { DataTable, LazyLoadEvent } from 'primeng/primeng';
import { PageResponse } from "../../support/paging";
import { MessageService } from '../../service/message.service';
import { MatDialog } from '@angular/material';
import { ConfirmDeleteDialogComponent } from "../../support/confirm-delete-dialog.component";
import { ProjectGroup } from './projectGroup';
import { ProjectGroupDetailComponent } from './projectGroup-detail.component';
import { ProjectGroupService } from './projectGroup.service';

@Component({
    moduleId: module.id,
	templateUrl: 'projectGroup-list.component.html',
	selector: 'projectGroup-list'
})
export class ProjectGroupListComponent {

    @Input() header = "ProjectGroups...";

    // When 'sub' is true, it means this list is used as a one-to-many list.
    // It belongs to a parent entity, as a result the addNew operation
    // must prefill the parent entity. The prefill is not done here, instead we
    // emit an event.
    // When 'sub' is false, we display basic search criterias
    @Input() sub : boolean;
    @Output() onAddNewClicked = new EventEmitter();

    projectGroupToDelete : ProjectGroup;

    // basic search criterias (visible if not in 'sub' mode)
    example : ProjectGroup = new ProjectGroup();

    // list is paginated
    currentPage : PageResponse<ProjectGroup> = new PageResponse<ProjectGroup>(0,0,[]);


    constructor(private router : Router,
        private projectGroupService : ProjectGroupService,
        private messageService : MessageService,
        private confirmDeleteDialog: MatDialog) {
    }

    /**
     * When used as a 'sub' component (to display one-to-many list), refreshes the table
     * content when the input changes.
     */
    ngOnChanges(changes: SimpleChanges) {
        this.loadPage({ first: 0, rows: 10, sortField: null, sortOrder: null, filters: null, multiSortMeta: null });
    }

    /**
     * Invoked when user presses the search button.
     */
    search(dt : DataTable) {
        if (!this.sub) {
            dt.reset();
            this.loadPage({ first: 0, rows: dt.rows, sortField: dt.sortField, sortOrder: dt.sortOrder, filters: null, multiSortMeta: dt.multiSortMeta });
        }
    }

    /**
     * Invoked automatically by primeng datatable.
     */
    loadPage(event : LazyLoadEvent) {
        this.projectGroupService.getPage(this.example, event).
            subscribe(
                pageResponse => this.currentPage = pageResponse,
                error => this.messageService.error('Could not get the results', error)
            );
    }

    onRowSelect(event : any) {
        let id =  event.data.id;
        this.router.navigate(['/projectGroup', id]);
    }

    addNew() {
        if (this.sub) {
            this.onAddNewClicked.emit("addNew");
        } else {
            this.router.navigate(['/projectGroup', 'new']);
        }
    }

    showDeleteDialog(rowData : any) {
        let projectGroupToDelete : ProjectGroup = <ProjectGroup> rowData;

        let dialogRef = this.confirmDeleteDialog.open(ConfirmDeleteDialogComponent);
        dialogRef.afterClosed().subscribe(result => {
            if (result === 'delete') {
                this.delete(projectGroupToDelete);
            }
        });
    }

    private delete(projectGroupToDelete : ProjectGroup) {
        let id =  projectGroupToDelete.id;

        this.projectGroupService.delete(id).
            subscribe(
                response => {
                    this.currentPage.remove(projectGroupToDelete);
                    this.messageService.info('Deleted OK', 'Angular Rocks!');
                },
                error => this.messageService.error('Could not delete!', error)
            );
    }
}