<?php
/**
 * SAML 2.0 remote IdP metadata for SimpleSAMLphp.
 *
 * Remember to remove the IdPs you don't use from this file.
 *
 * See: https://simplesamlphp.org/docs/stable/simplesamlphp-reference-idp-remote
 */


 $metadata['http://localhost/simplesaml/saml2/idp/metadata.php'] = [
    'name'                 => [
        'es' => 'OpenID en SIR',
    ],
    'description'          => 'OpenID en SIR',
    'SingleSignOnService'  => 'http://localhost/simplesaml/saml2/idp/SSOService.php',
    'SingleLogoutService'  => 'http://localhost/simplesaml/saml2/idp/SingleLogoutService.php',
    'certFingerprint'      => 'FINGERPRINT',
];
