/**
 * Windows API header module
 *
 * Translated from Windows SDK Headers
 *
 * License: Placed into public domain
 * Source: $(DRUNTIMESRC src/core/sys/windows/_winhttp.d)
 */
module core.sys.windows.winhttp;
version (Windows):
pragma(lib, "winhttp");
// FIXME: Grouping of constants. Windows SDK doesn't make this entirely clear
// FIXME: Verify WINHTTP_STATUS_CALLBACK function declaration works correctly

import core.sys.windows.w32api;
import core.sys.windows.winbase;
import core.sys.windows.windef;
import core.sys.windows.winsock2;  // Selective Imports BUG (: SOCKADDR_STORAGE;)

alias HINTERNET = void*;
alias LPHINTERNET = HINTERNET*;
alias INTERNET_PORT = WORD;
alias LPINTERNET_PORT = INTERNET_PORT*;
alias INTERNET_SCHEME = int;
alias LPINTERNET_SCHEME = INTERNET_SCHEME*;

// Protocol 'Manifests'
enum : DWORD {
    INTERNET_DEFAULT_PORT       = 0,
    INTERNET_DEFAULT_HTTP_PORT  = 80,
    INTERNET_DEFAULT_HTTPS_PORT = 443
}

// WinHttpOpen() Flags:
enum DWORD WINHTTP_FLAG_ASYNC = 0x10000000;

// WinHttpOpenRequest() Flags:
enum : DWORD {
    WINHTTP_FLAG_SECURE               = 0x00800000,
    WINHTTP_FLAG_ESCAPE_PERCENT       = 0x00000004,
    WINHTTP_FLAG_NULL_CODEPAGE        = 0x00000008,
    WINHTTP_FLAG_BYPASS_PROXY_CACHE   = 0x00000100,
    WINHTTP_FLAG_REFRESH              = WINHTTP_FLAG_BYPASS_PROXY_CACHE,
    WINHTTP_FLAG_ESCAPE_DISABLE       = 0x00000040,
    WINHTTP_FLAG_ESCAPE_DISABLE_QUERY = 0x00000080,

    SECURITY_FLAG_IGNORE_UNKNOWN_CA        = 0x00000100,
    SECURITY_FLAG_IGNORE_CERT_DATE_INVALID = 0x00002000,
    SECURITY_FLAG_IGNORE_CERT_CN_INVALID   = 0x00001000,
    SECURITY_FLAG_IGNORE_CERT_WRONG_USAGE  = 0x00000200
}

struct WINHTTP_ASYNC_RESULT {
    DWORD_PTR dwResult;
    DWORD dwError;
}
alias LPWINHTTP_ASYNC_RESULT = WINHTTP_ASYNC_RESULT*;

struct HTTP_VERSION_INFO {
    DWORD dwMajorVersion;
    DWORD dwMinorVersion;
}
alias LPHTTP_VERSION_INFO = HTTP_VERSION_INFO*;

// URL Scheme
enum : DWORD {
    INTERNET_SCHEME_HTTP  = 1,
    INTERNET_SCHEME_HTTPS = 2,
    INTERNET_SCHEME_FTP   = 3,
    INTERNET_SCHEME_SOCKS = 4
}

struct URL_COMPONENTS {
    DWORD   dwStructSize;
    LPWSTR  lpszScheme;
    DWORD   dwSchemeLength;
    INTERNET_SCHEME nScheme;
    LPWSTR  lpszHostName;
    DWORD   dwHostNameLength;
    INTERNET_PORT nPort;
    LPWSTR  lpszUserName;
    DWORD   dwUserNameLength;
    LPWSTR  lpszPassword;
    DWORD   dwPasswordLength;
    LPWSTR  lpszUrlPath;
    DWORD   dwUrlPathLength;
    LPWSTR  lpszExtraInfo;
    DWORD   dwExtraInfoLength;
}
alias LPURL_COMPONENTS = URL_COMPONENTS*;
alias URL_COMPONENTSW = URL_COMPONENTS;
alias LPURL_COMPONENTSW = URL_COMPONENTS*;

struct WINHTTP_PROXY_INFO {
    DWORD  dwAccessType;
    LPWSTR lpszProxy;
    LPWSTR lpszProxyBypass;
}
alias LPWINHTTP_PROXY_INFO = WINHTTP_PROXY_INFO*;
alias WINHTTP_PROXY_INFOW = WINHTTP_PROXY_INFO;
alias LPWINHTTP_PROXY_INFOW = WINHTTP_PROXY_INFO*;

struct WINHTTP_AUTOPROXY_OPTIONS {
    DWORD   dwFlags;
    DWORD   dwAutoDetectFlags;
    LPCWSTR lpszAutoConfigUrl;
    LPVOID  lpvReserved;
    DWORD   dwReserved;
    BOOL    fAutoLogonIfChallenged;
}

enum : DWORD {
    WINHTTP_AUTOPROXY_AUTO_DETECT           = 0x00000001,
    WINHTTP_AUTOPROXY_CONFIG_URL            = 0x00000002,
    WINHTTP_AUTOPROXY_HOST_KEEPCASE         = 0x00000004,
    WINHTTP_AUTOPROXY_HOST_LOWERCASE        = 0x00000008,
    WINHTTP_AUTOPROXY_RUN_INPROCESS         = 0x00010000,
    WINHTTP_AUTOPROXY_RUN_OUTPROCESS_ONLY   = 0x00020000,
    WINHTTP_AUTOPROXY_NO_DIRECTACCESS       = 0x00040000,
    WINHTTP_AUTOPROXY_NO_CACHE_CLIENT       = 0x00080000,
    WINHTTP_AUTOPROXY_NO_CACHE_SVC          = 0x00100000,

    WINHTTP_AUTOPROXY_SORT_RESULTS          = 0x00400000
}

// dwAutoDetectFlags
enum : DWORD {
    WINHTTP_AUTO_DETECT_TYPE_DHCP           = 0x00000001,
    WINHTTP_AUTO_DETECT_TYPE_DNS_A          = 0x00000002
}

struct WINHTTP_CERTIFICATE_INFO {
    FILETIME ftExpiry;
    FILETIME ftStart;
    LPWSTR lpszSubjectInfo;
    LPWSTR lpszIssuerInfo;
    LPWSTR lpszProtocolName;
    LPWSTR lpszSignatureAlgName;
    LPWSTR lpszEncryptionAlgName;
    DWORD dwKeySize;
}

// This structure is only defined #if _WS2DEF_ defined (from <ws2def.h>) - per Windows SDK
struct WINHTTP_CONNECTION_INFO {
    DWORD cbSize;
    SOCKADDR_STORAGE LocalAddress;
    SOCKADDR_STORAGE RemoteAddress;
}

// WinHttpTimeFromSystemTime
enum DWORD WINHTTP_TIME_FORMAT_BUFSIZE  = 62;

// CrackUrl, CombineUrl
enum : DWORD {
    ICU_NO_ENCODE           = 0x20000000,
    ICU_DECODE              = 0x10000000,
    ICU_NO_META             = 0x08000000,
    ICU_ENCODE_SPACES_ONLY  = 0x04000000,
    ICU_BROWSER_MODE        = 0x02000000,
    ICU_ENCODE_PERCENT      = 0x00001000
}
// WinHttpCrackUrl, WinHttpCreateUrl
enum : DWORD {
    ICU_ESCAPE            = 0x80000000,
    ICU_ESCAPE_AUTHORITY  = 0x00002000,
    ICU_REJECT_USERPWD    = 0x00004000
}
enum : DWORD {
    WINHTTP_ACCESS_TYPE_DEFAULT_PROXY             = 0,
    WINHTTP_ACCESS_TYPE_NO_PROXY                  = 1,
    WINHTTP_ACCESS_TYPE_NAMED_PROXY               = 3,
    WINHTTP_ACCESS_TYPE_AUTOMATIC_PROXY           = 4
}
// WinHttpOpen 'prettifiers'
enum LPCWSTR WINHTTP_NO_PROXY_NAME         = null;
enum LPCWSTR WINHTTP_NO_PROXY_BYPASS       = null;

enum LPVOID WINHTTP_NO_CLIENT_CERT_CONTEXT = null;

// WinHttp{Query|Set}Option
enum : DWORD {
    WINHTTP_FIRST_OPTION                         = WINHTTP_OPTION_CALLBACK,

    WINHTTP_OPTION_CALLBACK                      = 1,
    WINHTTP_OPTION_RESOLVE_TIMEOUT               = 2,
    WINHTTP_OPTION_CONNECT_TIMEOUT               = 3,
    WINHTTP_OPTION_CONNECT_RETRIES               = 4,
    WINHTTP_OPTION_SEND_TIMEOUT                  = 5,
    WINHTTP_OPTION_RECEIVE_TIMEOUT               = 6,
    WINHTTP_OPTION_RECEIVE_RESPONSE_TIMEOUT      = 7,
    WINHTTP_OPTION_HANDLE_TYPE                   = 9,
    WINHTTP_OPTION_READ_BUFFER_SIZE             = 12,
    WINHTTP_OPTION_WRITE_BUFFER_SIZE            = 13,
    WINHTTP_OPTION_PARENT_HANDLE                = 21,
    WINHTTP_OPTION_EXTENDED_ERROR               = 24,
    WINHTTP_OPTION_SECURITY_FLAGS               = 31,
    WINHTTP_OPTION_SECURITY_CERTIFICATE_STRUCT  = 32,
    WINHTTP_OPTION_URL                          = 34,
    WINHTTP_OPTION_SECURITY_KEY_BITNESS         = 36,
    WINHTTP_OPTION_PROXY                        = 38,
    WINHTTP_OPTION_PROXY_RESULT_ENTRY           = 39,

    WINHTTP_OPTION_USER_AGENT                   = 41,
    WINHTTP_OPTION_CONTEXT_VALUE                = 45,
    WINHTTP_OPTION_CLIENT_CERT_CONTEXT          = 47,
    WINHTTP_OPTION_REQUEST_PRIORITY             = 58,
    WINHTTP_OPTION_HTTP_VERSION                 = 59,
    WINHTTP_OPTION_DISABLE_FEATURE              = 63,

    WINHTTP_OPTION_CODEPAGE                     = 68,
    WINHTTP_OPTION_MAX_CONNS_PER_SERVER         = 73,
    WINHTTP_OPTION_MAX_CONNS_PER_1_0_SERVER     = 74,
    WINHTTP_OPTION_AUTOLOGON_POLICY             = 77,
    WINHTTP_OPTION_SERVER_CERT_CONTEXT          = 78,
    WINHTTP_OPTION_ENABLE_FEATURE               = 79,
    WINHTTP_OPTION_WORKER_THREAD_COUNT          = 80,
    WINHTTP_OPTION_PASSPORT_COBRANDING_TEXT     = 81,
    WINHTTP_OPTION_PASSPORT_COBRANDING_URL      = 82,
    WINHTTP_OPTION_CONFIGURE_PASSPORT_AUTH      = 83,
    WINHTTP_OPTION_SECURE_PROTOCOLS             = 84,
    WINHTTP_OPTION_ENABLETRACING                = 85,
    WINHTTP_OPTION_PASSPORT_SIGN_OUT            = 86,
    WINHTTP_OPTION_PASSPORT_RETURN_URL          = 87,
    WINHTTP_OPTION_REDIRECT_POLICY              = 88,
    WINHTTP_OPTION_MAX_HTTP_AUTOMATIC_REDIRECTS = 89,
    WINHTTP_OPTION_MAX_HTTP_STATUS_CONTINUE     = 90,
    WINHTTP_OPTION_MAX_RESPONSE_HEADER_SIZE     = 91,
    WINHTTP_OPTION_MAX_RESPONSE_DRAIN_SIZE      = 92,
    WINHTTP_OPTION_CONNECTION_INFO              = 93,
    WINHTTP_OPTION_CLIENT_CERT_ISSUER_LIST      = 94,
    WINHTTP_OPTION_SPN                          = 96,

    WINHTTP_OPTION_GLOBAL_PROXY_CREDS           = 97,
    WINHTTP_OPTION_GLOBAL_SERVER_CREDS          = 98,

    WINHTTP_OPTION_UNLOAD_NOTIFY_EVENT            = 99,
    WINHTTP_OPTION_REJECT_USERPWD_IN_URL          = 100,
    WINHTTP_OPTION_USE_GLOBAL_SERVER_CREDENTIALS  = 101,

    WINHTTP_OPTION_RECEIVE_PROXY_CONNECT_RESPONSE = 103,
    WINHTTP_OPTION_IS_PROXY_CONNECT_RESPONSE      = 104,

    WINHTTP_OPTION_SERVER_SPN_USED              = 106,
    WINHTTP_OPTION_PROXY_SPN_USED               = 107,

    WINHTTP_OPTION_SERVER_CBT                   = 108,

    WINHTTP_OPTION_UNSAFE_HEADER_PARSING          = 110,
    WINHTTP_OPTION_ASSURED_NON_BLOCKING_CALLBACKS = 111,

    WINHTTP_OPTION_UPGRADE_TO_WEB_SOCKET          = 114,
    WINHTTP_OPTION_WEB_SOCKET_CLOSE_TIMEOUT       = 115,
    WINHTTP_OPTION_WEB_SOCKET_KEEPALIVE_INTERVAL  = 116,

    WINHTTP_OPTION_DECOMPRESSION                  = 118,

    WINHTTP_OPTION_WEB_SOCKET_RECEIVE_BUFFER_SIZE = 122,
    WINHTTP_OPTION_WEB_SOCKET_SEND_BUFFER_SIZE    = 123,

    //WINHTTP_LAST_OPTION => Moved outside of enum - static if() constraints within enums

    WINHTTP_OPTION_USERNAME                      = 0x1000,
    WINHTTP_OPTION_PASSWORD                      = 0x1001,
    WINHTTP_OPTION_PROXY_USERNAME                = 0x1002,
    WINHTTP_OPTION_PROXY_PASSWORD                = 0x1003,

    WINHTTP_CONNS_PER_SERVER_UNLIMITED    = 0xFFFFFFFF,

    WINHTTP_AUTOLOGON_SECURITY_LEVEL_MEDIUM = 0,
    WINHTTP_AUTOLOGON_SECURITY_LEVEL_LOW    = 1,
    WINHTTP_AUTOLOGON_SECURITY_LEVEL_HIGH   = 2,

    WINHTTP_AUTOLOGON_SECURITY_LEVEL_DEFAULT = WINHTTP_AUTOLOGON_SECURITY_LEVEL_MEDIUM,

    WINHTTP_OPTION_REDIRECT_POLICY_NEVER                      = 0,
    WINHTTP_OPTION_REDIRECT_POLICY_DISALLOW_HTTPS_TO_HTTP     = 1,
    WINHTTP_OPTION_REDIRECT_POLICY_ALWAYS                     = 2,

    WINHTTP_OPTION_REDIRECT_POLICY_LAST      = WINHTTP_OPTION_REDIRECT_POLICY_ALWAYS,
    WINHTTP_OPTION_REDIRECT_POLICY_DEFAULT   = WINHTTP_OPTION_REDIRECT_POLICY_DISALLOW_HTTPS_TO_HTTP,

    WINHTTP_DISABLE_PASSPORT_AUTH    = 0x00000000,
    WINHTTP_ENABLE_PASSPORT_AUTH     = 0x10000000,
    WINHTTP_DISABLE_PASSPORT_KEYRING = 0x20000000,
    WINHTTP_ENABLE_PASSPORT_KEYRING  = 0x40000000,

    WINHTTP_DISABLE_COOKIES                   = 0x00000001,
    WINHTTP_DISABLE_REDIRECTS                 = 0x00000002,
    WINHTTP_DISABLE_AUTHENTICATION            = 0x00000004,
    WINHTTP_DISABLE_KEEP_ALIVE                = 0x00000008,

    WINHTTP_ENABLE_SSL_REVOCATION             = 0x00000001,
    WINHTTP_ENABLE_SSL_REVERT_IMPERSONATION   = 0x00000002,

    WINHTTP_DISABLE_SPN_SERVER_PORT           = 0x00000000,
    WINHTTP_ENABLE_SPN_SERVER_PORT            = 0x00000001,
    WINHTTP_OPTION_SPN_MASK                   = WINHTTP_ENABLE_SPN_SERVER_PORT
}

// Windows 8.1 SDK:
static if (_WIN32_WINNT >= 0x602) {
    enum DWORD WINHTTP_LAST_OPTION            = WINHTTP_OPTION_WEB_SOCKET_SEND_BUFFER_SIZE;
} else {    // Windows 7.0A SDK:
    enum DWORD WINHTTP_LAST_OPTION            = WINHTTP_OPTION_SERVER_CBT;
}

enum : DWORD {
    WINHTTP_DECOMPRESSION_FLAG_GZIP    = 0x00000001,
    WINHTTP_DECOMPRESSION_FLAG_DEFLATE = 0x00000002,
    WINHTTP_DECOMPRESSION_FLAG_ALL = (WINHTTP_DECOMPRESSION_FLAG_GZIP | WINHTTP_DECOMPRESSION_FLAG_DEFLATE)
}

struct WINHTTP_CREDS {
    LPSTR lpszUserName;
    LPSTR lpszPassword;
    LPSTR lpszRealm;
    DWORD dwAuthScheme;
    LPSTR lpszHostName;
    DWORD dwPort;
}
alias PWINHTTP_CREDS = WINHTTP_CREDS*;

struct WINHTTP_CREDS_EX {
    LPSTR lpszUserName;
    LPSTR lpszPassword;
    LPSTR lpszRealm;
    DWORD dwAuthScheme;
    LPSTR lpszHostName;
    DWORD dwPort;
    LPSTR lpszUrl;
}
alias PWINHTTP_CREDS_EX = WINHTTP_CREDS_EX*;

enum : DWORD {
    WINHTTP_HANDLE_TYPE_SESSION                = 1,
    WINHTTP_HANDLE_TYPE_CONNECT                = 2,
    WINHTTP_HANDLE_TYPE_REQUEST                = 3,

    WINHTTP_AUTH_SCHEME_BASIC      = 0x00000001,
    WINHTTP_AUTH_SCHEME_NTLM       = 0x00000002,
    WINHTTP_AUTH_SCHEME_PASSPORT   = 0x00000004,
    WINHTTP_AUTH_SCHEME_DIGEST     = 0x00000008,
    WINHTTP_AUTH_SCHEME_NEGOTIATE  = 0x00000010,

    WINHTTP_AUTH_TARGET_SERVER = 0x00000000,
    WINHTTP_AUTH_TARGET_PROXY  = 0x00000001,

    SECURITY_FLAG_SECURE                    = 0x00000001,
    SECURITY_FLAG_STRENGTH_WEAK             = 0x10000000,
    SECURITY_FLAG_STRENGTH_MEDIUM           = 0x40000000,
    SECURITY_FLAG_STRENGTH_STRONG           = 0x20000000,

    WINHTTP_CALLBACK_STATUS_FLAG_CERT_REV_FAILED         = 0x00000001,
    WINHTTP_CALLBACK_STATUS_FLAG_INVALID_CERT            = 0x00000002,
    WINHTTP_CALLBACK_STATUS_FLAG_CERT_REVOKED            = 0x00000004,
    WINHTTP_CALLBACK_STATUS_FLAG_INVALID_CA              = 0x00000008,
    WINHTTP_CALLBACK_STATUS_FLAG_CERT_CN_INVALID         = 0x00000010,
    WINHTTP_CALLBACK_STATUS_FLAG_CERT_DATE_INVALID       = 0x00000020,
    WINHTTP_CALLBACK_STATUS_FLAG_CERT_WRONG_USAGE        = 0x00000040,
    WINHTTP_CALLBACK_STATUS_FLAG_SECURITY_CHANNEL_ERROR  = 0x80000000,

    WINHTTP_FLAG_SECURE_PROTOCOL_SSL2   = 0x00000008,
    WINHTTP_FLAG_SECURE_PROTOCOL_SSL3   = 0x00000020,
    WINHTTP_FLAG_SECURE_PROTOCOL_TLS1   = 0x00000080,
    WINHTTP_FLAG_SECURE_PROTOCOL_TLS1_1 = 0x00000200,
    WINHTTP_FLAG_SECURE_PROTOCOL_TLS1_2 = 0x00000800,
    WINHTTP_FLAG_SECURE_PROTOCOL_ALL    = (WINHTTP_FLAG_SECURE_PROTOCOL_SSL2 |
                                                 WINHTTP_FLAG_SECURE_PROTOCOL_SSL3 |
                                                 WINHTTP_FLAG_SECURE_PROTOCOL_TLS1)
}

alias extern(Windows) int fnWINHTTP_STATUS_CALLBACK(HINTERNET hInternet, DWORD_PTR dwContext,
                          DWORD dwInternetStatus, LPVOID lpvStatusInformation,DWORD dwStatusInformationLength);
alias WINHTTP_STATUS_CALLBACK = fnWINHTTP_STATUS_CALLBACK*;
alias LPWINHTTP_STATUS_CALLBACK = WINHTTP_STATUS_CALLBACK*;

enum : DWORD {
    WINHTTP_CALLBACK_STATUS_RESOLVING_NAME          = 0x00000001,
    WINHTTP_CALLBACK_STATUS_NAME_RESOLVED           = 0x00000002,
    WINHTTP_CALLBACK_STATUS_CONNECTING_TO_SERVER    = 0x00000004,
    WINHTTP_CALLBACK_STATUS_CONNECTED_TO_SERVER     = 0x00000008,
    WINHTTP_CALLBACK_STATUS_SENDING_REQUEST         = 0x00000010,
    WINHTTP_CALLBACK_STATUS_REQUEST_SENT            = 0x00000020,
    WINHTTP_CALLBACK_STATUS_RECEIVING_RESPONSE      = 0x00000040,
    WINHTTP_CALLBACK_STATUS_RESPONSE_RECEIVED       = 0x00000080,
    WINHTTP_CALLBACK_STATUS_CLOSING_CONNECTION      = 0x00000100,
    WINHTTP_CALLBACK_STATUS_CONNECTION_CLOSED       = 0x00000200,
    WINHTTP_CALLBACK_STATUS_HANDLE_CREATED          = 0x00000400,
    WINHTTP_CALLBACK_STATUS_HANDLE_CLOSING          = 0x00000800,
    WINHTTP_CALLBACK_STATUS_DETECTING_PROXY         = 0x00001000,
    WINHTTP_CALLBACK_STATUS_REDIRECT                = 0x00004000,
    WINHTTP_CALLBACK_STATUS_INTERMEDIATE_RESPONSE   = 0x00008000,
    WINHTTP_CALLBACK_STATUS_SECURE_FAILURE          = 0x00010000,
    WINHTTP_CALLBACK_STATUS_HEADERS_AVAILABLE       = 0x00020000,
    WINHTTP_CALLBACK_STATUS_DATA_AVAILABLE          = 0x00040000,
    WINHTTP_CALLBACK_STATUS_READ_COMPLETE           = 0x00080000,
    WINHTTP_CALLBACK_STATUS_WRITE_COMPLETE          = 0x00100000,
    WINHTTP_CALLBACK_STATUS_REQUEST_ERROR           = 0x00200000,
    WINHTTP_CALLBACK_STATUS_SENDREQUEST_COMPLETE    = 0x00400000
}

enum : DWORD {
    WINHTTP_CALLBACK_STATUS_GETPROXYFORURL_COMPLETE = 0x01000000,
    WINHTTP_CALLBACK_STATUS_CLOSE_COMPLETE          = 0x02000000,
    WINHTTP_CALLBACK_STATUS_SHUTDOWN_COMPLETE       = 0x04000000
}

enum : DWORD {
    API_RECEIVE_RESPONSE        = 1,
    API_QUERY_DATA_AVAILABLE    = 2,
    API_READ_DATA               = 3,
    API_WRITE_DATA              = 4,
    API_SEND_REQUEST            = 5
}

enum : DWORD {
    WINHTTP_CALLBACK_FLAG_RESOLVE_NAME            = (WINHTTP_CALLBACK_STATUS_RESOLVING_NAME | WINHTTP_CALLBACK_STATUS_NAME_RESOLVED),
    WINHTTP_CALLBACK_FLAG_CONNECT_TO_SERVER       = (WINHTTP_CALLBACK_STATUS_CONNECTING_TO_SERVER | WINHTTP_CALLBACK_STATUS_CONNECTED_TO_SERVER),
    WINHTTP_CALLBACK_FLAG_SEND_REQUEST            = (WINHTTP_CALLBACK_STATUS_SENDING_REQUEST | WINHTTP_CALLBACK_STATUS_REQUEST_SENT),
    WINHTTP_CALLBACK_FLAG_RECEIVE_RESPONSE        = (WINHTTP_CALLBACK_STATUS_RECEIVING_RESPONSE | WINHTTP_CALLBACK_STATUS_RESPONSE_RECEIVED),
    WINHTTP_CALLBACK_FLAG_CLOSE_CONNECTION        = (WINHTTP_CALLBACK_STATUS_CLOSING_CONNECTION | WINHTTP_CALLBACK_STATUS_CONNECTION_CLOSED),
    WINHTTP_CALLBACK_FLAG_HANDLES                 = (WINHTTP_CALLBACK_STATUS_HANDLE_CREATED | WINHTTP_CALLBACK_STATUS_HANDLE_CLOSING),
    WINHTTP_CALLBACK_FLAG_DETECTING_PROXY         = WINHTTP_CALLBACK_STATUS_DETECTING_PROXY,
    WINHTTP_CALLBACK_FLAG_REDIRECT                = WINHTTP_CALLBACK_STATUS_REDIRECT,
    WINHTTP_CALLBACK_FLAG_INTERMEDIATE_RESPONSE   = WINHTTP_CALLBACK_STATUS_INTERMEDIATE_RESPONSE,
    WINHTTP_CALLBACK_FLAG_SECURE_FAILURE          = WINHTTP_CALLBACK_STATUS_SECURE_FAILURE,
    WINHTTP_CALLBACK_FLAG_SENDREQUEST_COMPLETE    = WINHTTP_CALLBACK_STATUS_SENDREQUEST_COMPLETE,
    WINHTTP_CALLBACK_FLAG_HEADERS_AVAILABLE       = WINHTTP_CALLBACK_STATUS_HEADERS_AVAILABLE,
    WINHTTP_CALLBACK_FLAG_DATA_AVAILABLE          = WINHTTP_CALLBACK_STATUS_DATA_AVAILABLE,
    WINHTTP_CALLBACK_FLAG_READ_COMPLETE           = WINHTTP_CALLBACK_STATUS_READ_COMPLETE,
    WINHTTP_CALLBACK_FLAG_WRITE_COMPLETE          = WINHTTP_CALLBACK_STATUS_WRITE_COMPLETE,
    WINHTTP_CALLBACK_FLAG_REQUEST_ERROR           = WINHTTP_CALLBACK_STATUS_REQUEST_ERROR
}

enum DWORD WINHTTP_CALLBACK_FLAG_GETPROXYFORURL_COMPLETE  = WINHTTP_CALLBACK_STATUS_GETPROXYFORURL_COMPLETE;

// Windows 8+/2012+
static if (_WIN32_WINNT >= 0x602)   {
  enum DWORD WINHTTP_CALLBACK_FLAG_ALL_COMPLETIONS        =  (WINHTTP_CALLBACK_STATUS_SENDREQUEST_COMPLETE
                                                        | WINHTTP_CALLBACK_STATUS_HEADERS_AVAILABLE
                                                        | WINHTTP_CALLBACK_STATUS_DATA_AVAILABLE
                                                        | WINHTTP_CALLBACK_STATUS_READ_COMPLETE
                                                        | WINHTTP_CALLBACK_STATUS_WRITE_COMPLETE
                                                        | WINHTTP_CALLBACK_STATUS_REQUEST_ERROR);
} else {
  enum DWORD WINHTTP_CALLBACK_FLAG_ALL_COMPLETIONS        =  (WINHTTP_CALLBACK_STATUS_SENDREQUEST_COMPLETE
                                                        | WINHTTP_CALLBACK_STATUS_HEADERS_AVAILABLE
                                                        | WINHTTP_CALLBACK_STATUS_DATA_AVAILABLE
                                                        | WINHTTP_CALLBACK_STATUS_READ_COMPLETE
                                                        | WINHTTP_CALLBACK_STATUS_WRITE_COMPLETE
                                                        | WINHTTP_CALLBACK_STATUS_REQUEST_ERROR
                                                        | WINHTTP_CALLBACK_STATUS_GETPROXYFORURL_COMPLETE);
}

enum DWORD  WINHTTP_CALLBACK_FLAG_ALL_NOTIFICATIONS      =  0xffffffff;

enum WINHTTP_INVALID_STATUS_CALLBACK        = (cast(WINHTTP_STATUS_CALLBACK)(-1L));

enum : DWORD {
    WINHTTP_QUERY_MIME_VERSION               = 0,
    WINHTTP_QUERY_CONTENT_TYPE               = 1,
    WINHTTP_QUERY_CONTENT_TRANSFER_ENCODING  = 2,
    WINHTTP_QUERY_CONTENT_ID                 = 3,
    WINHTTP_QUERY_CONTENT_DESCRIPTION        = 4,
    WINHTTP_QUERY_CONTENT_LENGTH             = 5,
    WINHTTP_QUERY_CONTENT_LANGUAGE           = 6,
    WINHTTP_QUERY_ALLOW                      = 7,
    WINHTTP_QUERY_PUBLIC                     = 8,
    WINHTTP_QUERY_DATE                       = 9,
    WINHTTP_QUERY_EXPIRES                    = 10,
    WINHTTP_QUERY_LAST_MODIFIED              = 11,
    WINHTTP_QUERY_MESSAGE_ID                 = 12,
    WINHTTP_QUERY_URI                        = 13,
    WINHTTP_QUERY_DERIVED_FROM               = 14,
    WINHTTP_QUERY_COST                       = 15,
    WINHTTP_QUERY_LINK                       = 16,
    WINHTTP_QUERY_PRAGMA                     = 17,
    WINHTTP_QUERY_VERSION                    = 18,
    WINHTTP_QUERY_STATUS_CODE                = 19,
    WINHTTP_QUERY_STATUS_TEXT                = 20,
    WINHTTP_QUERY_RAW_HEADERS                = 21,
    WINHTTP_QUERY_RAW_HEADERS_CRLF           = 22,
    WINHTTP_QUERY_CONNECTION                 = 23,
    WINHTTP_QUERY_ACCEPT                     = 24,
    WINHTTP_QUERY_ACCEPT_CHARSET             = 25,
    WINHTTP_QUERY_ACCEPT_ENCODING            = 26,
    WINHTTP_QUERY_ACCEPT_LANGUAGE            = 27,
    WINHTTP_QUERY_AUTHORIZATION              = 28,
    WINHTTP_QUERY_CONTENT_ENCODING           = 29,
    WINHTTP_QUERY_FORWARDED                  = 30,
    WINHTTP_QUERY_FROM                       = 31,
    WINHTTP_QUERY_IF_MODIFIED_SINCE          = 32,
    WINHTTP_QUERY_LOCATION                   = 33,
    WINHTTP_QUERY_ORIG_URI                   = 34,
    WINHTTP_QUERY_REFERER                    = 35,
    WINHTTP_QUERY_RETRY_AFTER                = 36,
    WINHTTP_QUERY_SERVER                     = 37,
    WINHTTP_QUERY_TITLE                      = 38,
    WINHTTP_QUERY_USER_AGENT                 = 39,
    WINHTTP_QUERY_WWW_AUTHENTICATE           = 40,
    WINHTTP_QUERY_PROXY_AUTHENTICATE         = 41,
    WINHTTP_QUERY_ACCEPT_RANGES              = 42,
    WINHTTP_QUERY_SET_COOKIE                 = 43,
    WINHTTP_QUERY_COOKIE                     = 44,
    WINHTTP_QUERY_REQUEST_METHOD             = 45,
    WINHTTP_QUERY_REFRESH                    = 46,
    WINHTTP_QUERY_CONTENT_DISPOSITION        = 47,

    // HTTP 1.1 defined headers

    WINHTTP_QUERY_AGE                        = 48,
    WINHTTP_QUERY_CACHE_CONTROL              = 49,
    WINHTTP_QUERY_CONTENT_BASE               = 50,
    WINHTTP_QUERY_CONTENT_LOCATION           = 51,
    WINHTTP_QUERY_CONTENT_MD5                = 52,
    WINHTTP_QUERY_CONTENT_RANGE              = 53,
    WINHTTP_QUERY_ETAG                       = 54,
    WINHTTP_QUERY_HOST                       = 55,
    WINHTTP_QUERY_IF_MATCH                   = 56,
    WINHTTP_QUERY_IF_NONE_MATCH              = 57,
    WINHTTP_QUERY_IF_RANGE                   = 58,
    WINHTTP_QUERY_IF_UNMODIFIED_SINCE        = 59,
    WINHTTP_QUERY_MAX_FORWARDS               = 60,
    WINHTTP_QUERY_PROXY_AUTHORIZATION        = 61,
    WINHTTP_QUERY_RANGE                      = 62,
    WINHTTP_QUERY_TRANSFER_ENCODING          = 63,
    WINHTTP_QUERY_UPGRADE                    = 64,
    WINHTTP_QUERY_VARY                       = 65,
    WINHTTP_QUERY_VIA                        = 66,
    WINHTTP_QUERY_WARNING                    = 67,
    WINHTTP_QUERY_EXPECT                     = 68,
    WINHTTP_QUERY_PROXY_CONNECTION           = 69,
    WINHTTP_QUERY_UNLESS_MODIFIED_SINCE      = 70,

    WINHTTP_QUERY_PROXY_SUPPORT              = 75,
    WINHTTP_QUERY_AUTHENTICATION_INFO        = 76,
    WINHTTP_QUERY_PASSPORT_URLS              = 77,
    WINHTTP_QUERY_PASSPORT_CONFIG            = 78,

    WINHTTP_QUERY_MAX                        = 78,

    WINHTTP_QUERY_CUSTOM                     = 65535,

    WINHTTP_QUERY_FLAG_REQUEST_HEADERS         = 0x80000000,

    WINHTTP_QUERY_FLAG_SYSTEMTIME              = 0x40000000,

    WINHTTP_QUERY_FLAG_NUMBER                  = 0x20000000
}

enum : DWORD {
    HTTP_STATUS_CONTINUE            = 100,
    HTTP_STATUS_SWITCH_PROTOCOLS    = 101,

    HTTP_STATUS_OK                  = 200,
    HTTP_STATUS_CREATED             = 201,
    HTTP_STATUS_ACCEPTED            = 202,
    HTTP_STATUS_PARTIAL             = 203,
    HTTP_STATUS_NO_CONTENT          = 204,
    HTTP_STATUS_RESET_CONTENT       = 205,
    HTTP_STATUS_PARTIAL_CONTENT     = 206,
    HTTP_STATUS_WEBDAV_MULTI_STATUS = 207,

    HTTP_STATUS_AMBIGUOUS           = 300,
    HTTP_STATUS_MOVED               = 301,
    HTTP_STATUS_REDIRECT            = 302,
    HTTP_STATUS_REDIRECT_METHOD     = 303,
    HTTP_STATUS_NOT_MODIFIED        = 304,
    HTTP_STATUS_USE_PROXY           = 305,
    HTTP_STATUS_REDIRECT_KEEP_VERB  = 307,

    HTTP_STATUS_BAD_REQUEST       = 400,
    HTTP_STATUS_DENIED            = 401,
    HTTP_STATUS_PAYMENT_REQ       = 402,
    HTTP_STATUS_FORBIDDEN         = 403,
    HTTP_STATUS_NOT_FOUND         = 404,
    HTTP_STATUS_BAD_METHOD        = 405,
    HTTP_STATUS_NONE_ACCEPTABLE   = 406,
    HTTP_STATUS_PROXY_AUTH_REQ    = 407,
    HTTP_STATUS_REQUEST_TIMEOUT   = 408,
    HTTP_STATUS_CONFLICT          = 409,
    HTTP_STATUS_GONE              = 410,
    HTTP_STATUS_LENGTH_REQUIRED   = 411,
    HTTP_STATUS_PRECOND_FAILED    = 412,
    HTTP_STATUS_REQUEST_TOO_LARGE = 413,
    HTTP_STATUS_URI_TOO_LONG      = 414,
    HTTP_STATUS_UNSUPPORTED_MEDIA = 415,
    HTTP_STATUS_RETRY_WITH        = 449,

    HTTP_STATUS_SERVER_ERROR      = 500,
    HTTP_STATUS_NOT_SUPPORTED     = 501,
    HTTP_STATUS_BAD_GATEWAY       = 502,
    HTTP_STATUS_SERVICE_UNAVAIL   = 503,
    HTTP_STATUS_GATEWAY_TIMEOUT   = 504,
    HTTP_STATUS_VERSION_NOT_SUP   = 505,

    HTTP_STATUS_FIRST             = HTTP_STATUS_CONTINUE,
    HTTP_STATUS_LAST              = HTTP_STATUS_VERSION_NOT_SUP
}

enum LPCWSTR WINHTTP_NO_REFERER             = null;
enum LPCWSTR * WINHTTP_DEFAULT_ACCEPT_TYPES = null;

enum : DWORD {
    WINHTTP_ADDREQ_INDEX_MASK     = 0x0000FFFF,
    WINHTTP_ADDREQ_FLAGS_MASK     = 0xFFFF0000,

    WINHTTP_ADDREQ_FLAG_ADD_IF_NEW = 0x10000000,

    WINHTTP_ADDREQ_FLAG_ADD        = 0x20000000,

    WINHTTP_ADDREQ_FLAG_COALESCE_WITH_COMMA       = 0x40000000,
    WINHTTP_ADDREQ_FLAG_COALESCE_WITH_SEMICOLON   = 0x01000000,
    WINHTTP_ADDREQ_FLAG_COALESCE                  = WINHTTP_ADDREQ_FLAG_COALESCE_WITH_COMMA,

    WINHTTP_ADDREQ_FLAG_REPLACE    = 0x80000000,

    WINHTTP_IGNORE_REQUEST_TOTAL_LENGTH = 0
}

enum LPCWSTR WINHTTP_NO_ADDITIONAL_HEADERS = null;
enum LPVOID WINHTTP_NO_REQUEST_DATA        = null;

enum LPCWSTR WINHTTP_HEADER_NAME_BY_INDEX  = null;
enum LPVOID WINHTTP_NO_OUTPUT_BUFFER       = null;
enum LPDWORD WINHTTP_NO_HEADER_INDEX       = null;

struct WINHTTP_CURRENT_USER_IE_PROXY_CONFIG {
    BOOL    fAutoDetect;
    LPWSTR  lpszAutoConfigUrl;
    LPWSTR  lpszProxy;
    LPWSTR  lpszProxyBypass;
}

// WinHttp API error returns
enum : DWORD {
    WINHTTP_ERROR_BASE                   = 12000,

    ERROR_WINHTTP_OUT_OF_HANDLES         = (WINHTTP_ERROR_BASE + 1),
    ERROR_WINHTTP_TIMEOUT                = (WINHTTP_ERROR_BASE + 2),
    ERROR_WINHTTP_INTERNAL_ERROR         = (WINHTTP_ERROR_BASE + 4),
    ERROR_WINHTTP_INVALID_URL            = (WINHTTP_ERROR_BASE + 5),
    ERROR_WINHTTP_UNRECOGNIZED_SCHEME    = (WINHTTP_ERROR_BASE + 6),
    ERROR_WINHTTP_NAME_NOT_RESOLVED      = (WINHTTP_ERROR_BASE + 7),
    ERROR_WINHTTP_INVALID_OPTION         = (WINHTTP_ERROR_BASE + 9),
    ERROR_WINHTTP_OPTION_NOT_SETTABLE    = (WINHTTP_ERROR_BASE + 11),
    ERROR_WINHTTP_SHUTDOWN               = (WINHTTP_ERROR_BASE + 12),

    ERROR_WINHTTP_LOGIN_FAILURE          = (WINHTTP_ERROR_BASE + 15),
    ERROR_WINHTTP_OPERATION_CANCELLED    = (WINHTTP_ERROR_BASE + 17),
    ERROR_WINHTTP_INCORRECT_HANDLE_TYPE  = (WINHTTP_ERROR_BASE + 18),
    ERROR_WINHTTP_INCORRECT_HANDLE_STATE = (WINHTTP_ERROR_BASE + 19),
    ERROR_WINHTTP_CANNOT_CONNECT         = (WINHTTP_ERROR_BASE + 29),
    ERROR_WINHTTP_CONNECTION_ERROR       = (WINHTTP_ERROR_BASE + 30),
    ERROR_WINHTTP_RESEND_REQUEST         = (WINHTTP_ERROR_BASE + 32),

    ERROR_WINHTTP_CLIENT_AUTH_CERT_NEEDED = (WINHTTP_ERROR_BASE, + 44),

    ERROR_WINHTTP_CANNOT_CALL_BEFORE_OPEN = (WINHTTP_ERROR_BASE + 100),
    ERROR_WINHTTP_CANNOT_CALL_BEFORE_SEND = (WINHTTP_ERROR_BASE + 101),
    ERROR_WINHTTP_CANNOT_CALL_AFTER_SEND  = (WINHTTP_ERROR_BASE + 102),
    ERROR_WINHTTP_CANNOT_CALL_AFTER_OPEN  = (WINHTTP_ERROR_BASE + 103),

    ERROR_WINHTTP_HEADER_NOT_FOUND           = (WINHTTP_ERROR_BASE + 150),
    ERROR_WINHTTP_INVALID_SERVER_RESPONSE    = (WINHTTP_ERROR_BASE + 152),
    ERROR_WINHTTP_INVALID_HEADER             = (WINHTTP_ERROR_BASE + 153),
    ERROR_WINHTTP_INVALID_QUERY_REQUEST      = (WINHTTP_ERROR_BASE + 154),
    ERROR_WINHTTP_HEADER_ALREADY_EXISTS      = (WINHTTP_ERROR_BASE + 155),
    ERROR_WINHTTP_REDIRECT_FAILED            = (WINHTTP_ERROR_BASE + 156),

    ERROR_WINHTTP_AUTO_PROXY_SERVICE_ERROR  = (WINHTTP_ERROR_BASE + 178),
    ERROR_WINHTTP_BAD_AUTO_PROXY_SCRIPT     = (WINHTTP_ERROR_BASE + 166),
    ERROR_WINHTTP_UNABLE_TO_DOWNLOAD_SCRIPT = (WINHTTP_ERROR_BASE + 167),
    ERROR_WINHTTP_UNHANDLED_SCRIPT_TYPE     = (WINHTTP_ERROR_BASE + 176),
    ERROR_WINHTTP_SCRIPT_EXECUTION_ERROR    = (WINHTTP_ERROR_BASE + 177),

    ERROR_WINHTTP_NOT_INITIALIZED        = (WINHTTP_ERROR_BASE + 172),
    ERROR_WINHTTP_SECURE_FAILURE         = (WINHTTP_ERROR_BASE + 175),

    ERROR_WINHTTP_SECURE_CERT_DATE_INVALID  = (WINHTTP_ERROR_BASE + 37),
    ERROR_WINHTTP_SECURE_CERT_CN_INVALID    = (WINHTTP_ERROR_BASE + 38),
    ERROR_WINHTTP_SECURE_INVALID_CA         = (WINHTTP_ERROR_BASE + 45),
    ERROR_WINHTTP_SECURE_CERT_REV_FAILED    = (WINHTTP_ERROR_BASE + 57),
    ERROR_WINHTTP_SECURE_CHANNEL_ERROR      = (WINHTTP_ERROR_BASE + 157),
    ERROR_WINHTTP_SECURE_INVALID_CERT       = (WINHTTP_ERROR_BASE + 169),
    ERROR_WINHTTP_SECURE_CERT_REVOKED       = (WINHTTP_ERROR_BASE + 170),
    ERROR_WINHTTP_SECURE_CERT_WRONG_USAGE   = (WINHTTP_ERROR_BASE + 179),

    ERROR_WINHTTP_AUTODETECTION_FAILED                  = (WINHTTP_ERROR_BASE + 180),
    ERROR_WINHTTP_HEADER_COUNT_EXCEEDED                 = (WINHTTP_ERROR_BASE + 181),
    ERROR_WINHTTP_HEADER_SIZE_OVERFLOW                  = (WINHTTP_ERROR_BASE + 182),
    ERROR_WINHTTP_CHUNKED_ENCODING_HEADER_SIZE_OVERFLOW = (WINHTTP_ERROR_BASE + 183),
    ERROR_WINHTTP_RESPONSE_DRAIN_OVERFLOW               = (WINHTTP_ERROR_BASE + 184),
    ERROR_WINHTTP_CLIENT_CERT_NO_PRIVATE_KEY            = (WINHTTP_ERROR_BASE + 185),
    ERROR_WINHTTP_CLIENT_CERT_NO_ACCESS_PRIVATE_KEY     = (WINHTTP_ERROR_BASE + 186),

    WINHTTP_ERROR_LAST                                  = (WINHTTP_ERROR_BASE + 186)
}

enum : DWORD {
    WINHTTP_RESET_STATE                  = 0x00000001,
    WINHTTP_RESET_SWPAD_CURRENT_NETWORK  = 0x00000002,
    WINHTTP_RESET_SWPAD_ALL              = 0x00000004,
    WINHTTP_RESET_SCRIPT_CACHE           = 0x00000008,
    WINHTTP_RESET_ALL                    = 0x0000FFFF,
    WINHTTP_RESET_NOTIFY_NETWORK_CHANGED = 0x00010000,
    WINHTTP_RESET_OUT_OF_PROC            = 0x00020000
}

enum : DWORD {
    WINHTTP_WEB_SOCKET_MAX_CLOSE_REASON_LENGTH = 123,
    WINHTTP_WEB_SOCKET_MIN_KEEPALIVE_VALUE     = 15000
}

// Version(Windows8) || Version(Windows2012):
static if (_WIN32_WINNT >= 0x602)
{
    enum WINHTTP_WEB_SOCKET_OPERATION : DWORD
    {
        WINHTTP_WEB_SOCKET_SEND_OPERATION                   = 0,
        WINHTTP_WEB_SOCKET_RECEIVE_OPERATION                = 1,
        WINHTTP_WEB_SOCKET_CLOSE_OPERATION                  = 2,
        WINHTTP_WEB_SOCKET_SHUTDOWN_OPERATION               = 3
    }
    enum WINHTTP_WEB_SOCKET_BUFFER_TYPE : DWORD
    {
        WINHTTP_WEB_SOCKET_BINARY_MESSAGE_BUFFER_TYPE       = 0,
        WINHTTP_WEB_SOCKET_BINARY_FRAGMENT_BUFFER_TYPE      = 1,
        WINHTTP_WEB_SOCKET_UTF8_MESSAGE_BUFFER_TYPE         = 2,
        WINHTTP_WEB_SOCKET_UTF8_FRAGMENT_BUFFER_TYPE        = 3,
        WINHTTP_WEB_SOCKET_CLOSE_BUFFER_TYPE                = 4
    }
    enum WINHTTP_WEB_SOCKET_CLOSE_STATUS : DWORD
    {
        WINHTTP_WEB_SOCKET_SUCCESS_CLOSE_STATUS                = 1000,
        WINHTTP_WEB_SOCKET_ENDPOINT_TERMINATED_CLOSE_STATUS    = 1001,
        WINHTTP_WEB_SOCKET_PROTOCOL_ERROR_CLOSE_STATUS         = 1002,
        WINHTTP_WEB_SOCKET_INVALID_DATA_TYPE_CLOSE_STATUS      = 1003,
        WINHTTP_WEB_SOCKET_EMPTY_CLOSE_STATUS                  = 1005,
        WINHTTP_WEB_SOCKET_ABORTED_CLOSE_STATUS                = 1006,
        WINHTTP_WEB_SOCKET_INVALID_PAYLOAD_CLOSE_STATUS        = 1007,
        WINHTTP_WEB_SOCKET_POLICY_VIOLATION_CLOSE_STATUS       = 1008,
        WINHTTP_WEB_SOCKET_MESSAGE_TOO_BIG_CLOSE_STATUS        = 1009,
        WINHTTP_WEB_SOCKET_UNSUPPORTED_EXTENSIONS_CLOSE_STATUS = 1010,
        WINHTTP_WEB_SOCKET_SERVER_ERROR_CLOSE_STATUS           = 1011,
        WINHTTP_WEB_SOCKET_SECURE_HANDSHAKE_ERROR_CLOSE_STATUS = 1015
    }
    struct WINHTTP_PROXY_RESULT_ENTRY {
        BOOL            fProxy;
        BOOL            fBypass;
        INTERNET_SCHEME ProxyScheme;
        PWSTR           pwszProxy;
        INTERNET_PORT   ProxyPort;
    }
    struct WINHTTP_PROXY_RESULT {
        DWORD cEntries;
        WINHTTP_PROXY_RESULT_ENTRY *pEntries;
    }
    struct WINHTTP_WEB_SOCKET_ASYNC_RESULT {
        WINHTTP_ASYNC_RESULT AsyncResult;
        WINHTTP_WEB_SOCKET_OPERATION Operation;
    }
    struct WINHTTP_WEB_SOCKET_STATUS {
        DWORD dwBytesTransferred;
        WINHTTP_WEB_SOCKET_BUFFER_TYPE eBufferType;
    }
}


extern (Windows) {
    BOOL WinHttpAddRequestHeaders(HINTERNET hRequest, LPCWSTR pwszHeaders, DWORD dwHeadersLength, DWORD dwModifiers);

    BOOL WinHttpCheckPlatform();

    BOOL WinHttpCloseHandle(HINTERNET hInternet);

    HINTERNET WinHttpConnect(HINTERNET hSession, LPCWSTR pswzServerName, INTERNET_PORT nServerPort, DWORD dwReserved);

    BOOL WinHttpCrackUrl(LPCWSTR pwszUrl, DWORD dwUrlLength, DWORD dwFlags, LPURL_COMPONENTS lpUrlComponents);

    BOOL WinHttpCreateUrl(LPURL_COMPONENTS lpUrlComponents, DWORD dwFlags, LPWSTR pwszUrl, LPDWORD lpdwUrlLength);
    BOOL WinHttpDetectAutoProxyConfigUrl(DWORD dwAutoDetectFlags, LPWSTR *ppwszAutoConfigUrl);

    BOOL WinHttpGetDefaultProxyConfiguration(WINHTTP_PROXY_INFO *pProxyInfo);
    BOOL WinHttpGetIEProxyConfigForCurrentUser(WINHTTP_CURRENT_USER_IE_PROXY_CONFIG *pProxyConfig);
    BOOL WinHttpGetProxyForUrl(HINTERNET hSession,  LPCWSTR lpcwszUrl,
                               WINHTTP_AUTOPROXY_OPTIONS *pAutoProxyOptions, WINHTTP_PROXY_INFO *pProxyInfo);

    HINTERNET WinHttpOpen(LPCWSTR pwszUserAgent, DWORD dwAccessType, LPCWSTR pwszProxyName,
                          LPCWSTR pwszProxyBypass, DWORD dwFlags);
    HINTERNET WinHttpOpenRequest(HINTERNET hConnect, LPCWSTR pwszVerb, LPCWSTR pwszObjectName,
                                 LPCWSTR pwszVersion, LPCWSTR pwszReferrer,
                                 LPCWSTR *ppwszAcceptTypes, DWORD dwFlags);

    BOOL WinHttpQueryAuthSchemes(HINTERNET hRequest, LPDWORD lpdwSupportedSchemes,
                                 LPDWORD lpdwFirstScheme, LPDWORD pdwAuthTarget);
    BOOL WinHttpQueryDataAvailable(HINTERNET hRequest, LPDWORD lpdwNumberOfBytesAvailable);
    BOOL WinHttpQueryHeaders(HINTERNET hRequest, DWORD dwInfoLevel, LPCWSTR pwszName,
                             LPVOID lpBuffer, LPDWORD lpdwBufferLength, LPDWORD lpdwIndex);
    BOOL WinHttpQueryOption(HINTERNET hInternet, DWORD dwOption, LPVOID lpBuffer,
                            LPDWORD lpdwBufferLength);

    BOOL WinHttpReadData(HINTERNET hRequest, LPVOID lpBuffer, DWORD dwNumberOfBytesToRead,
                         LPDWORD lpdwNumberOfBytesRead);
    BOOL WinHttpReceiveResponse(HINTERNET hRequest, LPVOID lpReserved);

    BOOL WinHttpSendRequest(HINTERNET hRequest, LPCWSTR pwszHeaders, DWORD dwHeadersLength,
                            LPVOID lpOptional, DWORD dwOptionalLength, DWORD dwTotalLength, DWORD_PTR dwContext);

    BOOL WinHttpSetCredentials(HINTERNET hRequest, DWORD AuthTargets, DWORD AuthScheme,
                               LPCWSTR pwszUserName, LPCWSTR pwszPassword, LPVOID pAuthParams);
    BOOL WinHttpSetDefaultProxyConfiguration(WINHTTP_PROXY_INFO *pProxyInfo);
    BOOL WinHttpSetOption(HINTERNET hInternet, DWORD dwOption, LPVOID lpBuffer, DWORD dwBufferLength);
    WINHTTP_STATUS_CALLBACK WinHttpSetStatusCallback(HINTERNET hInternet,
                                                     WINHTTP_STATUS_CALLBACK lpfnInternetCallback,
                                                     DWORD dwNotificationFlags, DWORD_PTR dwReserved);
    BOOL WinHttpSetTimeouts(HINTERNET hInternet, int dwResolveTimeout, int dwConnectTimeout,
                            int dwSendTimeout, int dwReceiveTimeout);

    BOOL WinHttpTimeFromSystemTime(const SYSTEMTIME *pst, LPWSTR pwszTime);
    BOOL WinHttpTimeToSystemTime(LPCWSTR pwszTime, SYSTEMTIME *pst);

    BOOL WinHttpWriteData(HINTERNET hRequest, LPCVOID lpBuffer, DWORD dwNumberOfBytesToWrite,
                          LPDWORD lpdwNumberOfBytesWritten);

  // Version(Windows8) || Version(Windows2012):
  static if (_WIN32_WINNT >= 0x602) {
    DWORD WinHttpCreateProxyResolver(HINTERNET hSession, HINTERNET *phResolver);
    void WinHttpFreeProxyResult(WINHTTP_PROXY_RESULT *pProxyResult);
    DWORD WinHttpGetProxyForUrlEx(HINTERNET hResolver, PCWSTR pcwszUrl,
                                  WINHTTP_AUTOPROXY_OPTIONS *pAutoProxyOptions, DWORD_PTR pContext);
    DWORD WinHttpGetProxyResult(HINTERNET hResolver, WINHTTP_PROXY_RESULT *pProxyResult);
    DWORD WinHttpResetAutoProxy(HINTERNET hSession, DWORD dwFlags);
    DWORD WinHttpWebSocketClose(HINTERNET hWebSocket, USHORT usStatus, PVOID pvReason, DWORD dwReasonLength);
    HINTERNET WinHttpWebSocketCompleteUpgrade(HINTERNET hRequest, DWORD_PTR pContext);
    DWORD WinHttpWebSocketQueryCloseStatus(HINTERNET hWebSocket, USHORT *pusStatus, PVOID pvReason,
                                           DWORD dwReasonLength, DWORD *pdwReasonLengthConsumed);
    DWORD WinHttpWebSocketReceive(HINTERNET hWebSocket, PVOID pvBuffer,  DWORD dwBufferLength,
                                  DWORD *pdwBytesRead, WINHTTP_WEB_SOCKET_BUFFER_TYPE *peBufferType);
    DWORD WinHttpWebSocketSend(HINTERNET hWebSocket, WINHTTP_WEB_SOCKET_BUFFER_TYPE eBufferType,
                               PVOID pvBuffer, DWORD dwBufferLength);
    DWORD WinHttpWebSocketShutdown(HINTERNET hWebSocket, USHORT usStatus, PVOID pvReason, DWORD dwReasonLength);
  }
}
