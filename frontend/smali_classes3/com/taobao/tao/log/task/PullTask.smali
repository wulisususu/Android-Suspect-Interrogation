.class public Lcom/taobao/tao/log/task/PullTask;
.super Ljava/lang/Object;
.source "PullTask.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/tao/log/task/PullTask$a;,
        Lcom/taobao/tao/log/task/PullTask$b;
    }
.end annotation


# static fields
.field private static TAG:Ljava/lang/String; = "TLOG.PullTask"


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/taobao/tao/log/task/PullTask$1;)V
    .locals 0

    .line 23
    invoke-direct {p0}, Lcom/taobao/tao/log/task/PullTask;-><init>()V

    return-void
.end method

.method public static getInstance()Lcom/taobao/tao/log/task/PullTask;
    .locals 1

    .line 38
    invoke-static {}, Lcom/taobao/tao/log/task/PullTask$b;->a()Lcom/taobao/tao/log/task/PullTask;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public handle(Lcom/taobao/tao/log/message/MessageReponse;)V
    .locals 4

    .line 72
    invoke-static {}, Lcom/taobao/tao/log/CommandDataCenter;->getInstance()Lcom/taobao/tao/log/CommandDataCenter;

    move-result-object v0

    iget-object v1, p1, Lcom/taobao/tao/log/message/MessageReponse;->serviceId:Ljava/lang/String;

    iget-object v2, p1, Lcom/taobao/tao/log/message/MessageReponse;->userId:Ljava/lang/String;

    iget-object v3, p1, Lcom/taobao/tao/log/message/MessageReponse;->dataId:Ljava/lang/String;

    iget-object p1, p1, Lcom/taobao/tao/log/message/MessageReponse;->result:Ljava/lang/String;

    .line 73
    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object p1

    .line 72
    invoke-virtual {v0, v1, v2, v3, p1}, Lcom/taobao/tao/log/CommandDataCenter;->onData(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[B)V

    return-void
.end method

.method public pull()V
    .locals 3

    .line 46
    :try_start_0
    invoke-static {}, Lcom/taobao/tao/log/upload/FileUploadHandler;->getInstance()Lcom/taobao/tao/log/upload/FileUploadHandler;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/upload/FileUploadHandler;->sendPullMsg()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    sget-object v1, Lcom/taobao/tao/log/task/PullTask;->TAG:Ljava/lang/String;

    const-string v2, "pull task error"

    .line 48
    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_0
    return-void
.end method

.method public start()V
    .locals 3

    .line 57
    invoke-static {}, Lcom/taobao/tao/log/upload/FileUploadHandler;->getInstance()Lcom/taobao/tao/log/upload/FileUploadHandler;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/upload/FileUploadHandler;->sendPullMsg()V

    .line 60
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/TLogInitializer;->getApplication()Landroid/app/Application;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 63
    invoke-static {}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->getInstance()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    move-result-object v0

    new-instance v1, Lcom/taobao/tao/log/task/PullTask$a;

    const/4 v2, 0x0

    invoke-direct {v1, p0, v2}, Lcom/taobao/tao/log/task/PullTask$a;-><init>(Lcom/taobao/tao/log/task/PullTask;Lcom/taobao/tao/log/task/PullTask$1;)V

    invoke-virtual {v0, v1}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->addObserver(Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;)V

    :cond_0
    return-void
.end method
