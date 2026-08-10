.class Lcom/taobao/tao/log/task/PullTask$a;
.super Ljava/lang/Object;
.source "PullTask.java"

# interfaces
.implements Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/tao/log/task/PullTask;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Lcom/taobao/tao/log/task/PullTask;


# direct methods
.method private constructor <init>(Lcom/taobao/tao/log/task/PullTask;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/tao/log/task/PullTask$a;->a:Lcom/taobao/tao/log/task/PullTask;

    .line 78
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/taobao/tao/log/task/PullTask;Lcom/taobao/tao/log/task/PullTask$1;)V
    .locals 0

    .line 78
    invoke-direct {p0, p1}, Lcom/taobao/tao/log/task/PullTask$a;-><init>(Lcom/taobao/tao/log/task/PullTask;)V

    return-void
.end method


# virtual methods
.method public onBackground(Landroid/app/Activity;)V
    .locals 0

    .line 87
    invoke-static {}, Lcom/taobao/tao/log/upload/FileUploadHandler;->getInstance()Lcom/taobao/tao/log/upload/FileUploadHandler;

    move-result-object p1

    invoke-virtual {p1}, Lcom/taobao/tao/log/upload/FileUploadHandler;->sendPullMsg()V

    return-void
.end method

.method public onForeground(Landroid/app/Activity;)V
    .locals 0

    .line 82
    invoke-static {}, Lcom/taobao/tao/log/upload/FileUploadHandler;->getInstance()Lcom/taobao/tao/log/upload/FileUploadHandler;

    move-result-object p1

    invoke-virtual {p1}, Lcom/taobao/tao/log/upload/FileUploadHandler;->sendPullMsg()V

    return-void
.end method
