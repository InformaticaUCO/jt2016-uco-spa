<?php

// Admin

$config = [
    'admin' => ['core:AdminPassword'],
];

// SAML

$config['jt2016'] = [
    'saml:SP',
    'privatekey' => 'saml.pem',
    'certificate' => 'saml.crt',
    'idp' => 'http://localhost/simplesaml/saml2/idp/metadata.php',
];

// OpenID

$config['openidsir'] = [
    'openid:OpenIDConsumer',
    'target' => 'https://yo.rediris.es/',
    'attributes.required' => [
             'openid.sreg.email',
             'openid.sreg.nickname',
    ],
];

