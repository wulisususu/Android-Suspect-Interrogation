.class public Lanet/channel/util/ErrorConstant;
.super Ljava/lang/Object;
.source "Taobao"


# static fields
.field public static final ERROR_ACCS_CUSTOM_FRAME_CB_NULL:I = -0x69

.field public static final ERROR_AUTH_EXCEPTION:I = -0x12e

.field public static final ERROR_CONNECT_EXCEPTION:I = -0x196

.field public static final ERROR_CONN_TIME_OUT:I = -0x190

.field public static final ERROR_DATA_LENGTH_NOT_MATCH:I = -0xce

.field public static final ERROR_DATA_TOO_LARGE:I = -0x12f

.field public static final ERROR_EXCEPTION:I = -0x65

.field public static final ERROR_GET_PROCESS_NULL:I = -0x6c

.field public static final ERROR_HOST_NOT_VERIFY_ERROR:I = -0x193

.field public static final ERROR_IO_EXCEPTION:I = -0x194

.field public static final ERROR_NO_NETWORK:I = -0xc8

.field public static final ERROR_NO_STRATEGY:I = -0xcb

.field public static final ERROR_OPEN_CONNECTION_NULL:I = -0x197
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final ERROR_PARAM_ILLEGAL:I = -0x66

.field public static final ERROR_REMOTE_CALL_FAIL:I = -0x67

.field public static final ERROR_REQUEST_CANCEL:I = -0xcc

.field public static final ERROR_REQUEST_FAIL:I = -0xc9

.field public static final ERROR_REQUEST_FORBIDDEN_IN_BG:I = -0xcd

.field public static final ERROR_REQUEST_TIME_OUT:I = -0xca

.field public static final ERROR_SESSION_INVALID:I = -0x12d

.field public static final ERROR_SOCKET_TIME_OUT:I = -0x191

.field public static final ERROR_SSL_ERROR:I = -0x192

.field public static final ERROR_TNET_EXCEPTION:I = -0x12c

.field public static final ERROR_TNET_REQUEST_FAIL:I = -0x130

.field public static final ERROR_UNKNOWN:I = -0x64

.field public static final ERROR_UNKNOWN_HOST_EXCEPTION:I = -0x195

.field public static final SC_OK:I = 0xc8

.field private static errorMsgMap:Landroid/util/SparseArray;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/util/SparseArray<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 49
    new-instance v0, Landroid/util/SparseArray;

    invoke-direct {v0}, Landroid/util/SparseArray;-><init>()V

    sput-object v0, Lanet/channel/util/ErrorConstant;->errorMsgMap:Landroid/util/SparseArray;

    const/16 v1, 0xc8

    const-string/jumbo v2, "\u8bf7\u6c42\u6210\u529f"

    .line 51
    invoke-virtual {v0, v1, v2}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    sget-object v0, Lanet/channel/util/ErrorConstant;->errorMsgMap:Landroid/util/SparseArray;

    const/16 v1, -0x64

    const-string/jumbo v2, "\u672a\u77e5\u9519\u8bef"

    .line 52
    invoke-virtual {v0, v1, v2}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    sget-object v0, Lanet/channel/util/ErrorConstant;->errorMsgMap:Landroid/util/SparseArray;

    const/16 v1, -0x65

    const-string/jumbo v2, "\u53d1\u751f\u5f02\u5e38"

    .line 53
    invoke-virtual {v0, v1, v2}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    sget-object v0, Lanet/channel/util/ErrorConstant;->errorMsgMap:Landroid/util/SparseArray;

    const/16 v1, -0x66

    const-string/jumbo v2, "\u975e\u6cd5\u53c2\u6570"

    .line 54
    invoke-virtual {v0, v1, v2}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    sget-object v0, Lanet/channel/util/ErrorConstant;->errorMsgMap:Landroid/util/SparseArray;

    const/16 v1, -0x67

    const-string/jumbo v2, "\u8fdc\u7a0b\u8c03\u7528\u5931\u8d25"

    .line 55
    invoke-virtual {v0, v1, v2}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    sget-object v0, Lanet/channel/util/ErrorConstant;->errorMsgMap:Landroid/util/SparseArray;

    const/16 v1, -0x69

    const-string v2, "ACCS\u81ea\u5b9a\u4e49\u5e27\u56de\u8c03\u4e3a\u7a7a"

    .line 56
    invoke-virtual {v0, v1, v2}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    sget-object v0, Lanet/channel/util/ErrorConstant;->errorMsgMap:Landroid/util/SparseArray;

    const/16 v1, -0x6c

    const-string/jumbo v2, "\u83b7\u53d6Process\u5931\u8d25"

    .line 57
    invoke-virtual {v0, v1, v2}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    sget-object v0, Lanet/channel/util/ErrorConstant;->errorMsgMap:Landroid/util/SparseArray;

    const/16 v1, -0xc8

    const-string/jumbo v2, "\u65e0\u7f51\u7edc"

    .line 59
    invoke-virtual {v0, v1, v2}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    sget-object v0, Lanet/channel/util/ErrorConstant;->errorMsgMap:Landroid/util/SparseArray;

    const/16 v1, -0xcb

    const-string/jumbo v2, "\u65e0\u7b56\u7565"

    .line 60
    invoke-virtual {v0, v1, v2}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    sget-object v0, Lanet/channel/util/ErrorConstant;->errorMsgMap:Landroid/util/SparseArray;

    const/16 v1, -0xca

    const-string/jumbo v2, "\u8bf7\u6c42\u8d85\u65f6"

    .line 61
    invoke-virtual {v0, v1, v2}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    sget-object v0, Lanet/channel/util/ErrorConstant;->errorMsgMap:Landroid/util/SparseArray;

    const/16 v1, -0xcc

    const-string/jumbo v2, "\u8bf7\u6c42\u88ab\u53d6\u6d88"

    .line 62
    invoke-virtual {v0, v1, v2}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    sget-object v0, Lanet/channel/util/ErrorConstant;->errorMsgMap:Landroid/util/SparseArray;

    const/16 v1, -0xcd

    const-string/jumbo v2, "\u8bf7\u6c42\u540e\u53f0\u88ab\u7981\u6b62"

    .line 63
    invoke-virtual {v0, v1, v2}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    sget-object v0, Lanet/channel/util/ErrorConstant;->errorMsgMap:Landroid/util/SparseArray;

    const/16 v1, -0xce

    const-string/jumbo v2, "\u8bf7\u6c42\u6536\u5230\u7684\u6570\u636e\u957f\u5ea6\u4e0eContent-Length\u4e0d\u5339\u914d"

    .line 64
    invoke-virtual {v0, v1, v2}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    sget-object v0, Lanet/channel/util/ErrorConstant;->errorMsgMap:Landroid/util/SparseArray;

    const/16 v1, -0x12c

    const-string v2, "Tnet\u5c42\u629b\u51fa\u5f02\u5e38"

    .line 66
    invoke-virtual {v0, v1, v2}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    sget-object v0, Lanet/channel/util/ErrorConstant;->errorMsgMap:Landroid/util/SparseArray;

    const/16 v1, -0x12d

    const-string v2, "Session\u4e0d\u53ef\u7528"

    .line 67
    invoke-virtual {v0, v1, v2}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    sget-object v0, Lanet/channel/util/ErrorConstant;->errorMsgMap:Landroid/util/SparseArray;

    const/16 v1, -0x12e

    const-string/jumbo v2, "\u9274\u6743\u5f02\u5e38"

    .line 68
    invoke-virtual {v0, v1, v2}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    sget-object v0, Lanet/channel/util/ErrorConstant;->errorMsgMap:Landroid/util/SparseArray;

    const/16 v1, -0x12f

    const-string/jumbo v2, "\u81ea\u5b9a\u4e49\u5e27\u6570\u636e\u8fc7\u5927"

    .line 69
    invoke-virtual {v0, v1, v2}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    sget-object v0, Lanet/channel/util/ErrorConstant;->errorMsgMap:Landroid/util/SparseArray;

    const/16 v1, -0x130

    const-string v2, "Tnet\u8bf7\u6c42\u5931\u8d25"

    .line 70
    invoke-virtual {v0, v1, v2}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    sget-object v0, Lanet/channel/util/ErrorConstant;->errorMsgMap:Landroid/util/SparseArray;

    const/16 v1, -0x190

    const-string/jumbo v2, "\u8fde\u63a5\u8d85\u65f6"

    .line 72
    invoke-virtual {v0, v1, v2}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    sget-object v0, Lanet/channel/util/ErrorConstant;->errorMsgMap:Landroid/util/SparseArray;

    const/16 v1, -0x191

    const-string v2, "Socket\u8d85\u65f6"

    .line 73
    invoke-virtual {v0, v1, v2}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    sget-object v0, Lanet/channel/util/ErrorConstant;->errorMsgMap:Landroid/util/SparseArray;

    const/16 v1, -0x192

    const-string v2, "SSL\u5931\u8d25"

    .line 74
    invoke-virtual {v0, v1, v2}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    sget-object v0, Lanet/channel/util/ErrorConstant;->errorMsgMap:Landroid/util/SparseArray;

    const/16 v1, -0x193

    const-string/jumbo v2, "\u57df\u540d\u672a\u8ba4\u8bc1"

    .line 75
    invoke-virtual {v0, v1, v2}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    sget-object v0, Lanet/channel/util/ErrorConstant;->errorMsgMap:Landroid/util/SparseArray;

    const/16 v1, -0x194

    const-string v2, "IO\u5f02\u5e38"

    .line 76
    invoke-virtual {v0, v1, v2}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    sget-object v0, Lanet/channel/util/ErrorConstant;->errorMsgMap:Landroid/util/SparseArray;

    const/16 v1, -0x195

    const-string/jumbo v2, "\u57df\u540d\u4e0d\u80fd\u89e3\u6790"

    .line 77
    invoke-virtual {v0, v1, v2}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    sget-object v0, Lanet/channel/util/ErrorConstant;->errorMsgMap:Landroid/util/SparseArray;

    const/16 v1, -0x196

    const-string/jumbo v2, "\u8fde\u63a5\u5f02\u5e38"

    .line 78
    invoke-virtual {v0, v1, v2}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static formatMsg(ILjava/lang/String;)Ljava/lang/String;
    .locals 1

    .line 86
    invoke-static {p0}, Lanet/channel/util/ErrorConstant;->getErrMsg(I)Ljava/lang/String;

    move-result-object p0

    const-string v0, ":"

    invoke-static {p0, v0, p1}, Lanet/channel/util/StringUtils;->concatString(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static getErrMsg(I)Ljava/lang/String;
    .locals 1

    sget-object v0, Lanet/channel/util/ErrorConstant;->errorMsgMap:Landroid/util/SparseArray;

    .line 82
    invoke-virtual {v0, p0}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Ljava/lang/String;

    invoke-static {p0}, Lanet/channel/util/StringUtils;->stringNull2Empty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method
