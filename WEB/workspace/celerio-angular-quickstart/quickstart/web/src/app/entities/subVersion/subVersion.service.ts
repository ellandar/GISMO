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
import { SubVersion } from './subVersion';
import { Observable } from 'rxjs/Rx';
import { catchError, map } from 'rxjs/operators';
import 'rxjs/add/observable/throw';

@Injectable()
export class SubVersionService {

    constructor(private http: HttpClient, private messageService : MessageService) {}

    /**
     * Get a SubVersion by id.
     */
    getSubVersion(id : any) : Observable<SubVersion> {
        return this.http.get('/api/subVersions/' + id)
            .pipe(
                map(response => new SubVersion(response)),
                catchError(this.handleError)
            );
    }

    /**
     * Update the passed subVersion.
     */
    update(subVersion : SubVersion) : Observable<SubVersion> {
        let body = subVersion;

        return this.http.put('/api/subVersions/', body)
            .pipe(
                map(response => new SubVersion(response)),
                catchError(this.handleError)
            );
    }

    /**
     * Load a page (for paginated datatable) of SubVersion using the passed
     * subVersion as an example for the search by example facility.
     */
    getPage(subVersion : SubVersion, event : LazyLoadEvent) : Observable<PageResponse<SubVersion>> {
        let req = new PageRequestByExample(subVersion, event);
        let body = req;

        return this.http.post<PageResponse<any>>('/api/subVersions/page', body)
            .pipe(
                map(pr =>  new PageResponse<SubVersion>(pr.totalPages, pr.totalElements, SubVersion.toArray(pr.content))),
                catchError(this.handleError)
            );
    }

    /**
     * Performs a search by example on 1 attribute (defined on server side) and returns at most 10 results.
     * Used by SubVersionCompleteComponent.
     */
    complete(query : string) : Observable<SubVersion[]> {
        let body = {'query': query, 'maxResults': 10};
        return this.http.post<any[]>('/api/subVersions/complete', body)
            .pipe(
                map(response => SubVersion.toArray(response)),
                catchError(this.handleError)
            );
    }

    /**
     * Delete an SubVersion by id.
     */
    delete(id : any) {
        return this.http.delete('/api/subVersions/' + id)
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
