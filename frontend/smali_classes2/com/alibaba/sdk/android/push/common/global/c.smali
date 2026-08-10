.class public Lcom/alibaba/sdk/android/push/common/global/c;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/alibaba/sdk/android/push/common/global/c$a;
    }
.end annotation


# static fields
.field public static final a:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final b:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final c:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final d:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final e:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final f:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final g:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final h:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final i:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final j:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final k:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final l:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final m:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final n:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final o:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final p:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final q:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final r:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final s:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final t:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final u:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final v:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final w:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final x:[Lcom/alibaba/sdk/android/error/ErrorCode;

.field private static final y:Lcom/alibaba/sdk/android/error/ErrorDefine;


# direct methods
.method static constructor <clinit>()V
    .locals 25

    new-instance v0, Lcom/alibaba/sdk/android/error/ErrorDefine;

    new-instance v1, Lcom/alibaba/sdk/android/push/common/global/c$a;

    const/4 v2, 0x0

    invoke-direct {v1, v2}, Lcom/alibaba/sdk/android/push/common/global/c$a;-><init>(Lcom/alibaba/sdk/android/push/common/global/c$1;)V

    const-string v2, "PUSH"

    invoke-direct {v0, v2, v1}, Lcom/alibaba/sdk/android/error/ErrorDefine;-><init>(Ljava/lang/String;Lcom/alibaba/sdk/android/error/CodeGenerator;)V

    sput-object v0, Lcom/alibaba/sdk/android/push/common/global/c;->y:Lcom/alibaba/sdk/android/error/ErrorDefine;

    const-string v1, "00000"

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v1

    const-string v2, "success"

    invoke-virtual {v1, v2}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v1

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v1

    sput-object v1, Lcom/alibaba/sdk/android/push/common/global/c;->a:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v2, "10101"

    invoke-virtual {v0, v2}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineServerError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v2

    const-string/jumbo v3, "\u53c2\u6570\u7f3a\u5931"

    invoke-virtual {v2, v3}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v2

    const-string/jumbo v3, "\u8bf7\u68c0\u67e5\u8bf7\u6c42\u53c2\u6570\u662f\u5426\u6b63\u786e"

    invoke-virtual {v2, v3}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v2

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v2

    sput-object v2, Lcom/alibaba/sdk/android/push/common/global/c;->b:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v4, "10102"

    invoke-virtual {v0, v4}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineServerError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v4

    const-string/jumbo v5, "\u53c2\u6570\u65e0\u6548"

    invoke-virtual {v4, v5}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v3

    invoke-virtual {v3}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v3

    sput-object v3, Lcom/alibaba/sdk/android/push/common/global/c;->c:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v4, "10103"

    invoke-virtual {v0, v4}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineServerError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v4

    const-string/jumbo v5, "\u670d\u52a1\u7aef\u7b7e\u540d\u4e0e\u5ba2\u6237\u7aef\u4e0d\u5339\u914d"

    invoke-virtual {v4, v5}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v4

    const-string/jumbo v5, "\u8bf7\u68c0\u67e5\u63a8\u9001\u914d\u7f6e\u662f\u5426\u6b63\u786e"

    invoke-virtual {v4, v5}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v4

    invoke-virtual {v4}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v4

    sput-object v4, Lcom/alibaba/sdk/android/push/common/global/c;->d:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v5, "10104"

    invoke-virtual {v0, v5}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineServerError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v5

    const-string v6, "Tag\u76f8\u5173\u9519\u8bef"

    invoke-virtual {v5, v6}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v5

    const-string/jumbo v6, "\u8bf7\u6839\u636e\u5177\u4f53\u9519\u8bef\u4fe1\u606f\u6392\u67e5\uff0c\u5982\u679c\u4e0d\u80fd\u89e3\u51b3\uff0c\u8bf7\u8054\u7cfb\u963f\u91cc\u4e91\u6280\u672f\u652f\u6301"

    invoke-virtual {v5, v6}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v5

    invoke-virtual {v5}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v5

    sput-object v5, Lcom/alibaba/sdk/android/push/common/global/c;->e:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v7, "10105"

    invoke-virtual {v0, v7}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineServerError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v7

    const-string v8, "Alias\u76f8\u5173\u9519\u8bef"

    invoke-virtual {v7, v8}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v7

    invoke-virtual {v7, v6}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v7

    invoke-virtual {v7}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v7

    sput-object v7, Lcom/alibaba/sdk/android/push/common/global/c;->f:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v8, "10106"

    invoke-virtual {v0, v8}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineServerError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v8

    const-string/jumbo v9, "\u670d\u52a1\u7aef\u5185\u90e8\u9519\u8bef"

    invoke-virtual {v8, v9}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v8

    const-string/jumbo v9, "\u8bf7\u6839\u636e\u5177\u4f53\u9519\u8bef\u4fe1\u606f\u8054\u7cfb\u963f\u91cc\u4e91\u6280\u672f\u652f\u6301"

    invoke-virtual {v8, v9}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v8

    invoke-virtual {v8}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v8

    sput-object v8, Lcom/alibaba/sdk/android/push/common/global/c;->g:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v10, "10107"

    invoke-virtual {v0, v10}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineAndroidError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v10

    const-string/jumbo v11, "\u7f51\u7edcIO\u9519\u8bef"

    invoke-virtual {v10, v11}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v10

    const-string/jumbo v11, "\u8bf7\u68c0\u67e5\u7f51\u7edc\u662f\u5426\u53ef\u7528"

    invoke-virtual {v10, v11}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v10

    invoke-virtual {v10, v6}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v10

    invoke-virtual {v10}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v10

    sput-object v10, Lcom/alibaba/sdk/android/push/common/global/c;->h:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v12, "10108"

    invoke-virtual {v0, v12}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v12

    const-string/jumbo v13, "\u8fd4\u56de\u7ed3\u679c\u89e3\u6790\u9519\u8bef"

    invoke-virtual {v12, v13}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v12

    const-string/jumbo v13, "\u8bf7\u4fdd\u7559\u5177\u4f53\u9519\u8bef\u4fe1\u606f\uff0c\u8054\u7cfb\u963f\u91cc\u4e91\u6280\u672f\u652f\u6301\u6392\u67e5"

    invoke-virtual {v12, v13}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v12

    invoke-virtual {v12}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v12

    sput-object v12, Lcom/alibaba/sdk/android/push/common/global/c;->i:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v14, "10109"

    invoke-virtual {v0, v14}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    const-string/jumbo v15, "\u7f51\u7edc\u8fde\u63a5\u5931\u8d25,\u8bf7\u68c0\u67e5\u7f51\u7edc\u914d\u7f6e"

    invoke-virtual {v14, v15}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    invoke-virtual {v14, v11}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    invoke-virtual {v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v14

    sput-object v14, Lcom/alibaba/sdk/android/push/common/global/c;->j:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v15, "10114"

    invoke-virtual {v0, v15}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v15

    move-object/from16 v16, v14

    const-string/jumbo v14, "\u5185\u90e8\u9519\u8bef"

    invoke-virtual {v15, v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    invoke-virtual {v14, v13}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    invoke-virtual {v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v14

    sput-object v14, Lcom/alibaba/sdk/android/push/common/global/c;->k:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v15, "10115"

    invoke-virtual {v0, v15}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v15

    move-object/from16 v17, v14

    const-string/jumbo v14, "\u901a\u9053\u6ce8\u518c\u72b6\u6001\u5f02\u5e38"

    invoke-virtual {v15, v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    invoke-virtual {v14, v13}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    invoke-virtual {v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v14

    sput-object v14, Lcom/alibaba/sdk/android/push/common/global/c;->l:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v15, "10118"

    invoke-virtual {v0, v15}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineServerError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v15

    move-object/from16 v18, v14

    const-string/jumbo v14, "\u5176\u5b83\u63a5\u53e3\u9519\u8bef"

    invoke-virtual {v15, v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    invoke-virtual {v14, v9}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v9

    invoke-virtual {v9}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v9

    sput-object v9, Lcom/alibaba/sdk/android/push/common/global/c;->m:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v14, "10119"

    invoke-virtual {v0, v14}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    const-string/jumbo v15, "\u975e\u4e3b\u8fdb\u7a0b\u4e0d\u7528\u521d\u59cb\u5316"

    invoke-virtual {v14, v15}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    const-string/jumbo v15, "\u5728\u975e\u4e3b\u8fdb\u7a0b\u6267\u884c\u521d\u59cb\u5316\u65f6\u89e6\u53d1\uff0c\u53ef\u4ee5\u5ffd\u7565"

    invoke-virtual {v14, v15}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    invoke-virtual {v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v14

    sput-object v14, Lcom/alibaba/sdk/android/push/common/global/c;->n:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v15, "10120"

    invoke-virtual {v0, v15}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v15

    move-object/from16 v19, v14

    const-string/jumbo v14, "\u63a8\u9001\u6ce8\u518c\u8d85\u65f6"

    invoke-virtual {v15, v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    invoke-virtual {v14, v13}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    invoke-virtual {v13}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v13

    sput-object v13, Lcom/alibaba/sdk/android/push/common/global/c;->o:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v14, "10121"

    invoke-virtual {v0, v14}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineAndroidError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    const-string/jumbo v15, "\u7f51\u7edc\u8bf7\u6c42\u5931\u8d25\uff0c\u8bf7\u68c0\u67e5\u7f51\u7edc\u662f\u5426\u53ef\u7528"

    invoke-virtual {v14, v15}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    invoke-virtual {v14, v11}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v11

    invoke-virtual {v11, v6}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v6

    invoke-virtual {v6}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v6

    sput-object v6, Lcom/alibaba/sdk/android/push/common/global/c;->p:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v11, "20101"

    invoke-virtual {v0, v11}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v11

    const-string/jumbo v14, "\u53c2\u6570\u8f93\u5165\u975e\u6cd5"

    invoke-virtual {v11, v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v11

    const-string/jumbo v14, "\u8bf7\u68c0\u67e5\u8bf7\u6c42\u7684\u8f93\u5165\u53c2\u6570\u662f\u5426\u6b63\u786e"

    invoke-virtual {v11, v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v11

    invoke-virtual {v11}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v11

    sput-object v11, Lcom/alibaba/sdk/android/push/common/global/c;->q:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v14, "20103"

    invoke-virtual {v0, v14}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    const-string v15, "appversion\u53c2\u6570\u9519\u8bef,\u8bf7\u68c0\u67e5\u60a8\u7684\u7248\u672c\u53f7,\u7248\u672c\u53f7\u4e0d\u80fd\u4e3anull\u6216\u957f\u5ea6\u4e0d\u80fd\u8d85\u8fc732\u4f4d"

    invoke-virtual {v14, v15}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    const-string/jumbo v15, "\u5f00\u542fdebug\u4f1a\u68c0\u67e5\u6b64\u9519\u8bef\uff0c\u8bf7\u68c0\u67e5\u5e94\u7528\u7248\u672c\u53f7\u662f\u5426\u8fc7\u957f"

    invoke-virtual {v14, v15}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    invoke-virtual {v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v14

    sput-object v14, Lcom/alibaba/sdk/android/push/common/global/c;->r:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v15, "20106"

    invoke-virtual {v0, v15}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v15

    move-object/from16 v20, v14

    const-string/jumbo v14, "\u6838\u5fc3\u7ec4\u4ef6\u672a\u914d\u7f6e"

    invoke-virtual {v15, v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    const-string/jumbo v15, "\u5f00\u542fdebug\u4f1a\u68c0\u67e5\u6b64\u9519\u8bef\uff0c\u8bf7\u68c0\u67e5\u662f\u5426\u5220\u9664\u4e86\u63a8\u9001\u7ec4\u4ef6\u7684\u58f0\u660e"

    invoke-virtual {v14, v15}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    invoke-virtual {v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v14

    sput-object v14, Lcom/alibaba/sdk/android/push/common/global/c;->s:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v15, "20107"

    invoke-virtual {v0, v15}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v15

    move-object/from16 v21, v14

    const-string/jumbo v14, "\u8fde\u7eedcrash\uff0c\u63a8\u9001\u670d\u52a1\u5173\u95ed"

    invoke-virtual {v15, v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    const-string/jumbo v15, "\u5e94\u7528\u521d\u59cb\u5316\u63a8\u9001\u540e\u5d29\u6e83\uff0c\u4f1a\u5728\u4e0b\u6b21\u542f\u52a8\u5173\u95ed\u63a8\u9001\u670d\u52a1\u3002\u8bf7\u68c0\u67e5\u5e94\u7528\u7684\u5d29\u6e83\u8bb0\u5f55"

    invoke-virtual {v14, v15}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    const-string/jumbo v15, "\u5f00\u53d1\u6d4b\u8bd5\u573a\u666f\u4e0b\uff0c\u4eba\u4e3a\u89e6\u53d1\u7684\uff0c\u8bf7\u6e05\u9664\u5e94\u7528\u6570\u636e\u6062\u590d"

    invoke-virtual {v14, v15}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    const-string/jumbo v15, "\u7ebf\u4e0a\u573a\u666f\u4f1a\u5c1d\u8bd5\u81ea\u52a8\u6062\u590d\uff0c\u5982\u679c\u4ecd\u7136\u5d29\u6e83\uff0c\u9700\u8981\u5347\u7ea7\u5e94\u7528\u7248\u672c\u624d\u4f1a\u6062\u590d"

    invoke-virtual {v14, v15}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    invoke-virtual {v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v14

    sput-object v14, Lcom/alibaba/sdk/android/push/common/global/c;->t:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v15, "20108"

    invoke-virtual {v0, v15}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v15

    move-object/from16 v22, v14

    const-string/jumbo v14, "\u672a\u521d\u59cb\u5316\uff0c\u8bf7\u5148\u8c03\u7528 PushServiceFactory\u7684init\u65b9\u6cd5"

    invoke-virtual {v15, v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    const-string/jumbo v15, "\u8bf7\u786e\u8ba4\u662f\u5426\u6b63\u5e38\u521d\u59cb\u5316"

    invoke-virtual {v14, v15}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    invoke-virtual {v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v14

    sput-object v14, Lcom/alibaba/sdk/android/push/common/global/c;->u:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v15, "20109"

    invoke-virtual {v0, v15}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v15

    move-object/from16 v23, v14

    const-string/jumbo v14, "\u5e9f\u5f03\u63a5\u53e3"

    invoke-virtual {v15, v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    const-string/jumbo v15, "\u8bf7\u67e5\u770b\u6587\u6863\uff0c\u4f7f\u7528\u5408\u9002\u7684api"

    invoke-virtual {v14, v15}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    invoke-virtual {v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v14

    sput-object v14, Lcom/alibaba/sdk/android/push/common/global/c;->v:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v15, "20110"

    invoke-virtual {v0, v15}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    const-string/jumbo v15, "\u5df2\u7ecf\u8c03\u7528\u6ce8\u518c\uff0c\u91cd\u590d\u8c03\u7528\u65e0\u6548"

    invoke-virtual {v0, v15}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    const-string v15, "register\u65b9\u6cd5\u5982\u679c\u5931\u8d25\u4e86\uff0c\u4f1a\u81ea\u52a8\u91cd\u8bd5\uff0c\u4e00\u822c\u60c5\u51b5\u4e0b\u4e0d\u9700\u8981\u91cd\u590d\u8c03\u7528"

    invoke-virtual {v0, v15}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    const-string/jumbo v15, "\u5982\u679c\u5e0c\u671b\u5185\u90e8\u91cd\u8bd5\u5931\u8d25\u7684\u60c5\u51b5\uff0c\u7531\u5916\u90e8\u91cd\u65b0\u8c03\u7528register\uff0c\u8bf7\u81f3\u5c11\u5728\u4e0a\u4e00\u6b21register\u5931\u8d25\u56de\u8c03\u4e24\u6b21\uff08\u786e\u8ba4\u5185\u90e8\u91cd\u8bd5\u8fd8\u662f\u5931\u8d25\uff09\u7684\u60c5\u51b5\u4e0b\uff0c\u5148\u8c03\u7528PushControlService\u7684reset\u65b9\u6cd5\uff0c\u7136\u540e\u518d\u8c03\u7528\u4e0b\u4e00\u6b21register\u65b9\u6cd5"

    invoke-virtual {v0, v15}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v0

    sput-object v0, Lcom/alibaba/sdk/android/push/common/global/c;->w:Lcom/alibaba/sdk/android/error/ErrorCode;

    const/16 v15, 0x19

    new-array v15, v15, [Lcom/alibaba/sdk/android/error/ErrorCode;

    const/16 v24, 0x0

    aput-object v1, v15, v24

    const/4 v1, 0x1

    aput-object v2, v15, v1

    const/4 v1, 0x2

    aput-object v3, v15, v1

    const/4 v1, 0x3

    aput-object v4, v15, v1

    const/4 v1, 0x4

    aput-object v5, v15, v1

    const/4 v1, 0x5

    aput-object v7, v15, v1

    const/4 v1, 0x6

    aput-object v8, v15, v1

    const/4 v1, 0x7

    aput-object v10, v15, v1

    const/16 v1, 0x8

    aput-object v12, v15, v1

    const/16 v1, 0x9

    aput-object v16, v15, v1

    const/16 v1, 0xa

    aput-object v17, v15, v1

    const/16 v1, 0xb

    aput-object v18, v15, v1

    const/16 v1, 0xc

    aput-object v9, v15, v1

    const/16 v1, 0xd

    aput-object v19, v15, v1

    const/16 v1, 0xe

    aput-object v13, v15, v1

    const/16 v1, 0xf

    aput-object v6, v15, v1

    const/16 v1, 0x10

    aput-object v11, v15, v1

    const/16 v1, 0x11

    aput-object v20, v15, v1

    const/16 v1, 0x12

    aput-object v21, v15, v1

    const/16 v1, 0x13

    aput-object v22, v15, v1

    const/16 v1, 0x14

    aput-object v23, v15, v1

    const/16 v1, 0x15

    aput-object v14, v15, v1

    const/16 v1, 0x16

    aput-object v0, v15, v1

    const/16 v0, 0x7b

    const-string v1, "accs\u9519\u8bef\u4fe1\u606f"

    invoke-static {v0, v1}, Lcom/alibaba/sdk/android/push/common/global/c;->a(ILjava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    const-string/jumbo v1, "\u683c\u5f0fACCS_123, 123\u4e3aaccs\u9519\u8bef\u7801\uff0c\u8bf7\u7ed3\u5408accs\u9519\u8bef\u7801\u6392\u67e5"

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v0

    const/16 v1, 0x17

    aput-object v0, v15, v1

    const-string/jumbo v0, "xxx"

    const-string v1, "agoo\u9519\u8bef\u4fe1\u606f"

    invoke-static {v0, v1}, Lcom/alibaba/sdk/android/push/common/global/c;->a(Ljava/lang/String;Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    const-string/jumbo v1, "\u683c\u5f0fAGOO_xxx, xxx\u4e3aagoo\u9519\u8bef\u7801\uff0c\u8bf7\u7ed3\u5408agoo\u9519\u8bef\u7801\u6392\u67e5"

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v0

    const/16 v1, 0x18

    aput-object v0, v15, v1

    sput-object v15, Lcom/alibaba/sdk/android/push/common/global/c;->x:[Lcom/alibaba/sdk/android/error/ErrorCode;

    return-void
.end method

.method public static a(ILjava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;
    .locals 3

    sget-object v0, Lcom/alibaba/sdk/android/push/common/global/c;->y:Lcom/alibaba/sdk/android/error/ErrorDefine;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "ACCS_"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p0

    return-object p0
.end method

.method public static a(Ljava/lang/String;Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;
    .locals 1

    sget-object v0, Lcom/alibaba/sdk/android/push/common/global/c;->y:Lcom/alibaba/sdk/android/error/ErrorDefine;

    invoke-virtual {v0, p0}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p0

    return-object p0
.end method

.method public static b(Ljava/lang/String;Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorCode;
    .locals 2

    invoke-virtual {p0}, Ljava/lang/String;->hashCode()I

    invoke-virtual {p0}, Ljava/lang/String;->hashCode()I

    move-result v0

    const/4 v1, -0x1

    sparse-switch v0, :sswitch_data_0

    goto :goto_0

    :sswitch_0
    const-string v0, "InvalidParam"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x6

    goto :goto_0

    :sswitch_1
    const-string v0, "AliasError"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    goto :goto_0

    :cond_1
    const/4 v1, 0x5

    goto :goto_0

    :sswitch_2
    const-string v0, "OK"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    goto :goto_0

    :cond_2
    const/4 v1, 0x4

    goto :goto_0

    :sswitch_3
    const-string v0, "SignNotMatch"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_3

    goto :goto_0

    :cond_3
    const/4 v1, 0x3

    goto :goto_0

    :sswitch_4
    const-string v0, "TagError"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_4

    goto :goto_0

    :cond_4
    const/4 v1, 0x2

    goto :goto_0

    :sswitch_5
    const-string v0, "MissingParam"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_5

    goto :goto_0

    :cond_5
    const/4 v1, 0x1

    goto :goto_0

    :sswitch_6
    const-string v0, "InternalError"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_6

    goto :goto_0

    :cond_6
    const/4 v1, 0x0

    :goto_0
    packed-switch v1, :pswitch_data_0

    sget-object v0, Lcom/alibaba/sdk/android/push/common/global/c;->m:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->copy()Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v1, ":"

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p0

    :goto_1
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object p0

    return-object p0

    :pswitch_0
    sget-object p0, Lcom/alibaba/sdk/android/push/common/global/c;->c:Lcom/alibaba/sdk/android/error/ErrorCode;

    :goto_2
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/error/ErrorCode;->copy()Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p0

    goto :goto_1

    :pswitch_1
    sget-object p0, Lcom/alibaba/sdk/android/push/common/global/c;->f:Lcom/alibaba/sdk/android/error/ErrorCode;

    goto :goto_2

    :pswitch_2
    sget-object p0, Lcom/alibaba/sdk/android/push/common/global/c;->a:Lcom/alibaba/sdk/android/error/ErrorCode;

    return-object p0

    :pswitch_3
    sget-object p0, Lcom/alibaba/sdk/android/push/common/global/c;->d:Lcom/alibaba/sdk/android/error/ErrorCode;

    goto :goto_2

    :pswitch_4
    sget-object p0, Lcom/alibaba/sdk/android/push/common/global/c;->e:Lcom/alibaba/sdk/android/error/ErrorCode;

    goto :goto_2

    :pswitch_5
    sget-object p0, Lcom/alibaba/sdk/android/push/common/global/c;->b:Lcom/alibaba/sdk/android/error/ErrorCode;

    goto :goto_2

    :pswitch_6
    sget-object p0, Lcom/alibaba/sdk/android/push/common/global/c;->g:Lcom/alibaba/sdk/android/error/ErrorCode;

    goto :goto_2

    :sswitch_data_0
    .sparse-switch
        -0x64ef06d5 -> :sswitch_6
        -0x3b671519 -> :sswitch_5
        -0x2b1bc952 -> :sswitch_4
        -0xfd96c51 -> :sswitch_3
        0x9dc -> :sswitch_2
        0x25b99b8 -> :sswitch_1
        0x285c2cf6 -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
