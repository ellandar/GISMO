//
// Source code generated by Celerio, a Jaxio product.
// Documentation: http://www.jaxio.com/documentation/celerio/
// Follow us on twitter: @jaxiosoft
// Need commercial support ? Contact us: info@jaxio.com
// Template pack-angular:web/src/app/entities/entity.service.ts.e.vm
//
import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse, HttpErrorResponse } from '@angular/common/http';
import { LazyLoadEvent } from 'primeng/primeng';
import { MessageService } from '../../service/message.service';
import { PageResponse, PageRequestByExample } from '../../support/paging';
import { TaskType } from './taskType';
import { Observable } from 'rxjs/Rx';
import { catchError, map } from 'rxjs/operators';
import 'rxjs/add/observable/throw';

@Injectable()
export class TaskTypeService {

    constructor(private http: HttpClient, private messageService : MessageService) {}

    /**
     * Get a TaskType by id.
     */
    getTaskType(id : any) : Observable<TaskType> {
        return this.http.get('/api/taskTypes/' + id)
            .pipe(
                map(response => new TaskType(response)),
                catchError(this.handleError)
            );
    }

    /**
     * Update the passed taskType.
     */
    update(taskType : TaskType) : Observable<TaskType> {
        let body = taskType;

        return this.http.put('/api/taskTypes/', body)
            .pipe(
                map(response => new TaskType(response)),
                catchError(this.handleError)
            );
    }

    /**
     * Load a page (for paginated datatable) of TaskType using the passed
     * taskType as an example for the search by example facility.
     */
    getPage(taskType : TaskType, event : LazyLoadEvent) : Observable<PageResponse<TaskType>> {
        let req = new PageRequestByExample(taskType, event);
        let body = req;

        return this.http.post<PageResponse<any>>('/api/taskTypes/page', body)
            .pipe(
                map(pr =>  new PageResponse<TaskType>(pr.totalPages, pr.totalElements, TaskType.toArray(pr.content))),
                catchError(this.handleError)
            );
    }

    /**
     * Performs a search by example on 1 attribute (defined on server side) and returns at most 10 results.
     * Used by TaskTypeCompleteComponent.
     */
    complete(query : string) : Observable<TaskType[]> {
        let body = {'query': query, 'maxResults': 10};
        return this.http.post<any[]>('/api/taskTypes/complete', body)
            .pipe(
                map(response => TaskType.toArray(response)),
                catchError(this.handleError)
            );
    }

    /**
     * Delete an TaskType by id.
     */
    delete(id : any) {
        return this.http.delete('/api/taskTypes/' + id)
            .pipe(catchError(this.handleError));
    }

    // sample method from angular doc
    private handleError (error: HttpErrorResponse) {
        // TODO: seems we cannot use messageService from here...
        let errMsg = (error.message) ? error.message : 'Server error';
        console.error(errMsg);
        if (error.status === 401 ) {
            window.location.href = '/';
        }
        return Observable.throw(errMsg);
    }
}
