.class public Lcom/taobao/agoo/a;
.super Ljava/lang/Object;
.source "Taobao"


# static fields
.field public static final ACCS_CHECK_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final AGOO_NOT_BIND:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final INVALID_ARG:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final REGISTER_DATA_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final REMOVE_ALIAS_FAIL_NO_ALIAS:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final REMOVE_ALIAS_FAIL_NO_TOKEN:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final SUCCESS:Lcom/alibaba/sdk/android/error/ErrorCode;

.field private static final a:Lcom/alibaba/sdk/android/error/ErrorDefine;

.field public static final codes:[Lcom/alibaba/sdk/android/error/ErrorCode;


# direct methods
.method static constructor <clinit>()V
    .locals 9

    .line 14
    new-instance v0, Lcom/alibaba/sdk/android/error/ErrorDefine;

    const-string v1, "EAGOO"

    invoke-direct {v0, v1}, Lcom/alibaba/sdk/android/error/ErrorDefine;-><init>(Ljava/lang/String;)V

    sput-object v0, Lcom/taobao/agoo/a;->a:Lcom/alibaba/sdk/android/error/ErrorDefine;

    const-string v1, "success"

    .line 16
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v1

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v1

    sput-object v1, Lcom/taobao/agoo/a;->SUCCESS:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v2, "remove_alias_fail_no_token"

    .line 18
    invoke-virtual {v0, v2}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v2

    const-string v3, "\u79fb\u9664\u522b\u540d\u5931\u8d25\uff0c\u672c\u5730\u6ca1\u6709\u522b\u540d\u8bb0\u5f55"

    .line 19
    invoke-virtual {v2, v3}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v2

    const-string v4, "\u8bf7\u68c0\u67e5\u8f93\u5165\u7684\u522b\u540d\u662f\u5426\u6b63\u786e"

    .line 20
    invoke-virtual {v2, v4}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v2

    const-string v5, "\u4f4e\u7248\u672c\u63a8\u9001\u6709\u6982\u7387\u51fa\u73b0\uff0c\u6dfb\u52a0\u522b\u540d\u540e\uff0c\u5e94\u7528\u7684\u6570\u636e\u88ab\u6e05\u9664\uff0c\u5bfc\u81f4sdk\u5185\u90e8\u5b58\u50a8\u7684\u522b\u540d\u4fe1\u606f\u4e22\u5931\uff0c\u65e0\u6cd5\u79fb\u9664"

    .line 21
    invoke-virtual {v2, v5}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v2

    .line 22
    invoke-virtual {v2}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v2

    sput-object v2, Lcom/taobao/agoo/a;->REMOVE_ALIAS_FAIL_NO_TOKEN:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v6, "remove_alias_fail_no_alias"

    .line 24
    invoke-virtual {v0, v6}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v6

    .line 25
    invoke-virtual {v6, v3}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v3

    .line 26
    invoke-virtual {v3, v4}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v3

    .line 27
    invoke-virtual {v3, v5}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v3

    .line 28
    invoke-virtual {v3}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v3

    sput-object v3, Lcom/taobao/agoo/a;->REMOVE_ALIAS_FAIL_NO_ALIAS:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v4, "invalid_arg"

    .line 30
    invoke-virtual {v0, v4}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v4

    const-string v5, "\u8bf7\u6c42\u53c2\u6570\u9519\u8bef"

    .line 31
    invoke-virtual {v4, v5}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v4

    const-string v5, "\u8bf7\u68c0\u67e5\u8f93\u5165\u53c2\u6570"

    .line 32
    invoke-virtual {v4, v5}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v4

    .line 33
    invoke-virtual {v4}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v4

    sput-object v4, Lcom/taobao/agoo/a;->INVALID_ARG:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v5, "accs_disabled"

    .line 35
    invoke-virtual {v0, v5}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v5

    const-string v6, "accs\u68c0\u67e5\u4e0d\u901a\u8fc7"

    .line 36
    invoke-virtual {v5, v6}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v5

    const-string v6, "\u8bf7\u68c0\u67e5\u521d\u59cb\u5316\u662f\u5426\u6210\u529f"

    .line 37
    invoke-virtual {v5, v6}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v5

    const-string v7, "\u8bf7\u68c0\u67e5\u914d\u7f6e\u662f\u5426\u6b63\u786e"

    .line 38
    invoke-virtual {v5, v7}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v5

    const-string v7, "\u8bf7\u68c0\u67e5\u8bf7\u6c42\u662f\u5426\u662f\u5728\u4e3b\u8fdb\u7a0b"

    .line 39
    invoke-virtual {v5, v7}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v5

    .line 40
    invoke-virtual {v5}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v5

    sput-object v5, Lcom/taobao/agoo/a;->ACCS_CHECK_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v7, "agoo_not_bind"

    .line 42
    invoke-virtual {v0, v7}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v7

    const-string v8, "\u8bf7\u5148\u6ce8\u518c\u521d\u59cb\u5316agoo"

    .line 43
    invoke-virtual {v7, v8}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v7

    .line 44
    invoke-virtual {v7, v6}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v6

    .line 45
    invoke-virtual {v6}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v6

    sput-object v6, Lcom/taobao/agoo/a;->AGOO_NOT_BIND:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v7, "register_data_error"

    .line 47
    invoke-virtual {v0, v7}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    const-string v7, "\u6784\u9020\u6ce8\u518c\u6570\u636e\u5931\u8d25"

    .line 48
    invoke-virtual {v0, v7}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    const-string v7, "\u8bf7\u68c0\u67e5\u914d\u7f6e\u53c2\u6570\u662f\u5426\u6b63\u786e\uff0c\u521d\u59cb\u5316\u662f\u5426\u6210\u529f"

    .line 49
    invoke-virtual {v0, v7}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    .line 50
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v0

    sput-object v0, Lcom/taobao/agoo/a;->REGISTER_DATA_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

    const/16 v0, 0x8

    new-array v0, v0, [Lcom/alibaba/sdk/android/error/ErrorCode;

    const/4 v7, 0x0

    aput-object v1, v0, v7

    const/4 v1, 0x1

    aput-object v2, v0, v1

    const/4 v1, 0x2

    aput-object v3, v0, v1

    const/4 v1, 0x3

    aput-object v4, v0, v1

    const/4 v1, 0x4

    aput-object v5, v0, v1

    const/4 v1, 0x5

    aput-object v6, v0, v1

    const/16 v1, 0x7b

    const-string v2, "accs \u9519\u8bef\u4fe1\u606f"

    .line 63
    invoke-static {v1, v2}, Lcom/taobao/agoo/a;->a(ILjava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v1

    const-string v2, "\u683c\u5f0fEAGOO_ACCS_123, 123\u4e3aaccs\u9519\u8bef\u7801\uff0c\u8bf7\u7ed3\u5408accs\u9519\u8bef\u7801\u6392\u67e5"

    invoke-virtual {v1, v2}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v1

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v1

    const/4 v2, 0x6

    aput-object v1, v0, v2

    const-string v1, "XXX"

    const-string v2, "\u670d\u52a1\u9519\u8bef\u4fe1\u606f"

    .line 64
    invoke-static {v1, v2}, Lcom/taobao/agoo/a;->a(Ljava/lang/String;Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v1

    const-string v2, "\u683c\u5f0fEAGOO_SERVER_XXX, XXX\u4e3aagoo\u670d\u52a1\u9519\u8bef\u7801\uff0c\u8bf7\u8054\u7cfb\u963f\u91cc\u4e91\u6280\u672f\u652f\u6301\u6392\u67e5"

    invoke-virtual {v1, v2}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v1

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v1

    const/4 v2, 0x7

    aput-object v1, v0, v2

    sput-object v0, Lcom/taobao/agoo/a;->codes:[Lcom/alibaba/sdk/android/error/ErrorCode;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a(ILjava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;
    .locals 2

    sget-object v0, Lcom/taobao/agoo/a;->a:Lcom/alibaba/sdk/android/error/ErrorDefine;

    const-string v1, "ACCS"

    .line 53
    invoke-static {p0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, v1, p0}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineError(Ljava/lang/String;Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p0

    const-string p1, "accs\u5e95\u5c42\u9519\u8bef\uff0c\u9700\u8981\u6839\u636e\u9519\u8bef\u7801\u6392\u67e5"

    invoke-virtual {p0, p1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p0

    return-object p0
.end method

.method public static a(Ljava/lang/String;Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;
    .locals 1

    sget-object v0, Lcom/taobao/agoo/a;->a:Lcom/alibaba/sdk/android/error/ErrorDefine;

    .line 57
    invoke-virtual {v0, p0}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineServerError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p0

    const-string p1, "agoo \u670d\u52a1\u62a5\u9519\uff0c\u8bf7\u8054\u7cfb\u6280\u672f\u652f\u6301\u6392\u67e5"

    invoke-virtual {p0, p1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p0

    return-object p0
.end method
