<?php
App::uses('AppModel', 'Model');

class User extends AppModel
{
    /**
     * Use database config
     *
     * @var string
     */
	public $useDbConfig = 'recore';

    /**
     * Display field
     *
     * @var string
     */
	public $displayField = 'user_id';
}
