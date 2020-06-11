<?php
App::uses('AppModel', 'Model');

class Note extends AppModel
{
    /**
     * Display field
     *
     * @var string
     */
	public $displayField = 'note_id';

	public $belongsTo = [
	    'User',
    ];
}
