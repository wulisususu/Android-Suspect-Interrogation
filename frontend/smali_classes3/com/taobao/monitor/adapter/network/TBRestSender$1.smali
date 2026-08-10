.class Lcom/taobao/monitor/adapter/network/TBRestSender$1;
.super Ljava/lang/Object;
.source "TBRestSender.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/adapter/network/TBRestSender;->send(Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/taobao/monitor/adapter/network/TBRestSender;

.field final synthetic val$content:Ljava/lang/String;

.field final synthetic val$topic:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/adapter/network/TBRestSender;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010,
            0x1010,
            0x1010
        }
        names = {
            "this$0",
            "val$content",
            "val$topic"
        }
    .end annotation

    iput-object p1, p0, Lcom/taobao/monitor/adapter/network/TBRestSender$1;->this$0:Lcom/taobao/monitor/adapter/network/TBRestSender;

    iput-object p2, p0, Lcom/taobao/monitor/adapter/network/TBRestSender$1;->val$content:Ljava/lang/String;

    iput-object p3, p0, Lcom/taobao/monitor/adapter/network/TBRestSender$1;->val$topic:Ljava/lang/String;

    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 8

    const-string v0, "TBRestSender"

    const/4 v1, 0x1

    :try_start_0
    new-array v2, v1, [Ljava/lang/Object;

    iget-object v3, p0, Lcom/taobao/monitor/adapter/network/TBRestSender$1;->val$content:Ljava/lang/String;

    const/4 v4, 0x0

    aput-object v3, v2, v4

    .line 35
    invoke-static {v0, v2}, Lcom/taobao/monitor/impl/logger/Logger;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    move v2, v4

    move v3, v2

    :goto_0
    add-int/lit8 v5, v2, 0x1

    const/4 v6, 0x2

    if-ge v2, v6, :cond_1

    iget-object v2, p0, Lcom/taobao/monitor/adapter/network/TBRestSender$1;->this$0:Lcom/taobao/monitor/adapter/network/TBRestSender;

    iget-object v3, p0, Lcom/taobao/monitor/adapter/network/TBRestSender$1;->val$topic:Ljava/lang/String;

    iget-object v6, p0, Lcom/taobao/monitor/adapter/network/TBRestSender$1;->val$content:Ljava/lang/String;

    .line 37
    invoke-static {v2, v3, v6}, Lcom/taobao/monitor/adapter/network/TBRestSender;->access$000(Lcom/taobao/monitor/adapter/network/TBRestSender;Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    new-array v2, v1, [Ljava/lang/Object;

    .line 39
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "send success"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    aput-object v5, v2, v4

    invoke-static {v0, v2}, Lcom/taobao/monitor/impl/logger/Logger;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_1

    :cond_0
    move v2, v5

    goto :goto_0

    :cond_1
    :goto_1
    if-nez v3, :cond_2

    iget-object v0, p0, Lcom/taobao/monitor/adapter/network/TBRestSender$1;->this$0:Lcom/taobao/monitor/adapter/network/TBRestSender;

    iget-object v2, p0, Lcom/taobao/monitor/adapter/network/TBRestSender$1;->val$topic:Ljava/lang/String;

    iget-object v5, p0, Lcom/taobao/monitor/adapter/network/TBRestSender$1;->val$content:Ljava/lang/String;

    .line 45
    invoke-static {v0, v2, v5}, Lcom/taobao/monitor/adapter/network/TBRestSender;->access$100(Lcom/taobao/monitor/adapter/network/TBRestSender;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/taobao/monitor/adapter/network/TBRestSender$1;->this$0:Lcom/taobao/monitor/adapter/network/TBRestSender;

    .line 46
    invoke-static {v0, v1}, Lcom/taobao/monitor/adapter/network/TBRestSender;->access$202(Lcom/taobao/monitor/adapter/network/TBRestSender;Z)Z

    :cond_2
    if-eqz v3, :cond_3

    iget-object v0, p0, Lcom/taobao/monitor/adapter/network/TBRestSender$1;->this$0:Lcom/taobao/monitor/adapter/network/TBRestSender;

    .line 49
    invoke-static {v0}, Lcom/taobao/monitor/adapter/network/TBRestSender;->access$200(Lcom/taobao/monitor/adapter/network/TBRestSender;)Z

    move-result v0

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/taobao/monitor/adapter/network/TBRestSender$1;->this$0:Lcom/taobao/monitor/adapter/network/TBRestSender;

    .line 50
    invoke-static {v0}, Lcom/taobao/monitor/adapter/network/TBRestSender;->access$300(Lcom/taobao/monitor/adapter/network/TBRestSender;)V

    iget-object v0, p0, Lcom/taobao/monitor/adapter/network/TBRestSender$1;->this$0:Lcom/taobao/monitor/adapter/network/TBRestSender;

    .line 51
    invoke-static {v0, v4}, Lcom/taobao/monitor/adapter/network/TBRestSender;->access$202(Lcom/taobao/monitor/adapter/network/TBRestSender;Z)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_2

    :catchall_0
    move-exception v0

    .line 55
    invoke-static {v0}, Lcom/taobao/monitor/impl/logger/Logger;->throwException(Ljava/lang/Throwable;)V

    :cond_3
    :goto_2
    return-void
.end method
