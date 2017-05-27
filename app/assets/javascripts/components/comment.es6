import CommentForm from './comment_form';
import CommentList from "./comment_list";

class Comment extends React.Component {

    static get contextTypes() {
        return {
            actions: React.PropTypes.object.isRequired
        }
    }

    static get propTypes() {
    return {
        id:   React.PropTypes.number,
        user: React.PropTypes.string,
        body: React.PropTypes.string,
        rank: React.PropTypes.number,
        }
    }

    constructor() {
        super();
        this.state = { isReplying: false }
    }

    onToggleReply() {
        this.setState({isReplying: !this.state.isReplying})
    }

    onUpvote(event) {
        this.context.actions.upvoteComment(this.props)
    }

    onCommentSubmitted(event) {
        this.setState({isReplying: false})
    }

    render() {
        const replyText = this.state.isReplying ? 'Hide' : 'Reply';
        return(
        <li className='row'>
            <blockquote>
                {this.props.body}
                <br />
                <cite>
                    by: {this.props.author}
                    <span className='label label-default pull-right'>{this.props.rank}</span>
                </cite>
            </blockquote>
            <button className='btn btn-small btn-primary' onClick={this.onToggleReply.bind(this)}>{replyText}</button>
            <button className='btn btn-small' onClick={this.onUpvote.bind(this)}>+1</button>
            {/*почему-то трубует передачи именно как хэша "параметр-значение*/}
            <CommentForm
                id={this.props.id}
                isReplying={this.state.isReplying}
                onCommentSubmitted={this.onCommentSubmitted.bind(this)}
            />
            {/*вложенный список комментариев*/}
            <CommentList parent_id={this.props.id} />
        </li>
        )
    }
}

export default Comment;