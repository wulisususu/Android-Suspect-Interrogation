.class Lcom/taobao/monitor/adapter/logger/LoggerAdapter$1;
.super Ljava/lang/Object;
.source "LoggerAdapter.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/adapter/logger/LoggerAdapter;->log(Ljava/lang/String;[Ljava/lang/Object;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/taobao/monitor/adapter/logger/LoggerAdapter;

.field final synthetic val$msg:[Ljava/lang/Object;

.field final synthetic val$tag:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/adapter/logger/LoggerAdapter;Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010,
            0x1010,
            0x1010
        }
        names = {
            "this$0",
            "val$tag",
            "val$msg"
        }
    .end annotation

    iput-object p1, p0, Lcom/taobao/monitor/adapter/logger/LoggerAdapter$1;->this$0:Lcom/taobao/monitor/adapter/logger/LoggerAdapter;

    iput-object p2, p0, Lcom/taobao/monitor/adapter/logger/LoggerAdapter$1;->val$tag:Ljava/lang/String;

    iput-object p3, p0, Lcom/taobao/monitor/adapter/logger/LoggerAdapter$1;->val$msg:[Ljava/lang/Object;

    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    :try_start_0
    const-string v0, "apm"

    iget-object v1, p0, Lcom/taobao/monitor/adapter/logger/LoggerAdapter$1;->val$tag:Ljava/lang/String;

    iget-object v2, p0, Lcom/taobao/monitor/adapter/logger/LoggerAdapter$1;->this$0:Lcom/taobao/monitor/adapter/logger/LoggerAdapter;

    iget-object v3, p0, Lcom/taobao/monitor/adapter/logger/LoggerAdapter$1;->val$msg:[Ljava/lang/Object;

    .line 19
    invoke-static {v2, v3}, Lcom/taobao/monitor/adapter/logger/LoggerAdapter;->access$000(Lcom/taobao/monitor/adapter/logger/LoggerAdapter;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/taobao/tao/log/TLog;->loge(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 21
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    :goto_0
    return-void
.end method
