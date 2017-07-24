import AppDispatcher from 'app_dispatcher';
import Constants from 'constants';
import Api from 'api';

class Actions {

    constructor(vacancyId) {
        this.vacancyId = vacancyId;
        this.watchInterval = setInterval(this.watch.bind(this), 1000)
    }

    setComments(params) {
        AppDispatcher.dispatch({
            actionType: Constants.SET_COMMENTS,
            comments: params
        })
    }

    upvoteComment(comment) {
        Api.put(`/vacancies/${this.vacancyId}/comments/${comment.id}/upvote`).then(comment => {
            AppDispatcher.dispatch({
                actionType: Constants.UPVOTE_COMMENT,
                comment: comment
            });
        });
    }

    addComment(params) {
        Api.post(`/vacancies/${this.vacancyId}/comments`, {
            comment: params
        }).then(comment => {
            AppDispatcher.dispatch({
                actionType: Constants.ADD_COMMENT,
                comment: comment
            });
        });
    }

    watch() {
        Api.get(`/vacancies/${this.vacancyId}/comments`).then(comments => {
            this.setComments(comments);
        });
    }
}

export default Actions;