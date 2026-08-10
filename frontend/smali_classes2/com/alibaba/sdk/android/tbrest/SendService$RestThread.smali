.class public Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;
.super Ljava/lang/Object;
.source "SendService.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/alibaba/sdk/android/tbrest/SendService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "RestThread"
.end annotation


# instance fields
.field private aArg1:Ljava/lang/Object;

.field private aArg2:Ljava/lang/Object;

.field private aArg3:Ljava/lang/Object;

.field private aEventId:I

.field private aExtData:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private aPage:Ljava/lang/String;

.field private aTimestamp:J

.field private adashxServerHost:Ljava/lang/String;

.field private appKey:Ljava/lang/String;

.field private context:Landroid/content/Context;

.field private isUrl:Ljava/lang/Boolean;

.field private mSendService:Lcom/alibaba/sdk/android/tbrest/SendService;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 252
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    .line 258
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    iput-object v0, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->isUrl:Ljava/lang/Boolean;

    return-void
.end method

.method public constructor <init>(Lcom/alibaba/sdk/android/tbrest/SendService;Ljava/lang/String;Ljava/lang/String;Landroid/content/Context;Ljava/lang/String;JLjava/lang/String;ILjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/util/Map;Ljava/lang/Boolean;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/alibaba/sdk/android/tbrest/SendService;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            "J",
            "Ljava/lang/String;",
            "I",
            "Ljava/lang/Object;",
            "Ljava/lang/Object;",
            "Ljava/lang/Object;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/Boolean;",
            ")V"
        }
    .end annotation

    .line 271
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 p2, 0x0

    .line 258
    invoke-static {p2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    iput-object p4, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->context:Landroid/content/Context;

    iput-object p5, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->adashxServerHost:Ljava/lang/String;

    iput-wide p6, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->aTimestamp:J

    iput-object p8, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->aPage:Ljava/lang/String;

    iput p9, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->aEventId:I

    iput-object p10, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->aArg1:Ljava/lang/Object;

    iput-object p11, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->aArg2:Ljava/lang/Object;

    iput-object p12, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->aArg3:Ljava/lang/Object;

    iput-object p13, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->aExtData:Ljava/util/Map;

    iput-object p3, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->appKey:Ljava/lang/String;

    iput-object p14, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->isUrl:Ljava/lang/Boolean;

    iput-object p1, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->mSendService:Lcom/alibaba/sdk/android/tbrest/SendService;

    return-void
.end method


# virtual methods
.method public run()V
    .locals 13

    :try_start_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->isUrl:Ljava/lang/Boolean;

    .line 289
    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->mSendService:Lcom/alibaba/sdk/android/tbrest/SendService;

    iget-object v2, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->appKey:Ljava/lang/String;

    iget-object v3, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->context:Landroid/content/Context;

    iget-object v4, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->adashxServerHost:Ljava/lang/String;

    iget-wide v5, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->aTimestamp:J

    iget-object v7, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->aPage:Ljava/lang/String;

    iget v8, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->aEventId:I

    iget-object v9, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->aArg1:Ljava/lang/Object;

    iget-object v10, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->aArg2:Ljava/lang/Object;

    iget-object v11, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->aArg3:Ljava/lang/Object;

    iget-object v12, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->aExtData:Ljava/util/Map;

    .line 290
    invoke-static/range {v1 .. v12}, Lcom/alibaba/sdk/android/tbrest/rest/e;->b(Lcom/alibaba/sdk/android/tbrest/SendService;Ljava/lang/String;Landroid/content/Context;Ljava/lang/String;JLjava/lang/String;ILjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/util/Map;)Z

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->mSendService:Lcom/alibaba/sdk/android/tbrest/SendService;

    iget-object v2, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->appKey:Ljava/lang/String;

    iget-object v3, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->context:Landroid/content/Context;

    iget-object v4, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->adashxServerHost:Ljava/lang/String;

    iget-wide v5, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->aTimestamp:J

    iget-object v7, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->aPage:Ljava/lang/String;

    iget v8, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->aEventId:I

    iget-object v9, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->aArg1:Ljava/lang/Object;

    iget-object v10, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->aArg2:Ljava/lang/Object;

    iget-object v11, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->aArg3:Ljava/lang/Object;

    iget-object v12, p0, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;->aExtData:Ljava/util/Map;

    .line 294
    invoke-static/range {v1 .. v12}, Lcom/alibaba/sdk/android/tbrest/rest/e;->a(Lcom/alibaba/sdk/android/tbrest/SendService;Ljava/lang/String;Landroid/content/Context;Ljava/lang/String;JLjava/lang/String;ILjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/util/Map;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    const-string v1, "send log asyn error "

    .line 299
    invoke-static {v1, v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    :goto_0
    return-void
.end method
