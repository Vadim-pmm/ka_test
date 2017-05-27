class CommentForm extends React.Component {

    static get contextTypes() {
        return {
            actions: React.PropTypes.object.isRequired
        }
    }

    static get PropTypes() {
        return {
            isReplying: React.PropTypes.bool,
            onCommmentSubmitted: React.PropTypes.func,
            parent_id: React.PropTypes.number
        }
    }

    constructor(props) {
        super();
        this.defaultState = { body: '', author: '', parent_id: props.id };
        this.state = this.defaultState;
    }

    submitComment(event) {
        event.preventDefault();
        this.context.actions.addComment(this.state);
        this.setState(this.defaultState);
        if (this.props.onCommentSubmitted) {
            this.props.onCommentSubmitted()
        }
    }

    onFieldChange(event) {
        let prop = {};
        prop[event.target.name] = event.target.value;
        this.setState(prop);
    }

    render() {
    return <div>
        <form className={ this.props.isReplying ? '' : 'hide'} >
            <label>Author</label><br />
            <input type='text' name='author' onChange={this.onFieldChange.bind(this)} value={this.state.author} />
            <br />
            <label>Comment</label><br />
            <textarea name='body' value={this.state.body} onChange={this.onFieldChange.bind(this)} />
            <br />
            <button onClick={this.submitComment.bind(this)} type='submit' >Опубликовать</button>
        </form>
    </div>;
    }
}

export default CommentForm;