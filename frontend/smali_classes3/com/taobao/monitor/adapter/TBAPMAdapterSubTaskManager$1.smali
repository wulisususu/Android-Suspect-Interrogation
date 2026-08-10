.class Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$1;
.super Ljava/lang/Object;
.source "TBAPMAdapterSubTaskManager.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager;->onStartTask(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$cpuStartTime:J

.field final synthetic val$isMainThread:Z

.field final synthetic val$name:Ljava/lang/String;

.field final synthetic val$threadName:Ljava/lang/String;

.field final synthetic val$timeStamp:J


# direct methods
.method constructor <init>(Ljava/lang/String;JJLjava/lang/String;Z)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x1010,
            0x1010,
            0x1010,
            0x1010,
            0x1010
        }
        names = {
            "val$name",
            "val$timeStamp",
            "val$cpuStartTime",
            "val$threadName",
            "val$isMainThread"
        }
    .end annotation

    iput-object p1, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$1;->val$name:Ljava/lang/String;

    iput-wide p2, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$1;->val$timeStamp:J

    iput-wide p4, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$1;->val$cpuStartTime:J

    iput-object p6, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$1;->val$threadName:Ljava/lang/String;

    iput-boolean p7, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$1;->val$isMainThread:Z

    .line 39
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .line 42
    invoke-static {}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager;->access$000()Z

    move-result v0

    if-nez v0, :cond_0

    .line 43
    sget-object v0, Lcom/taobao/monitor/procedure/ProcedureManagerProxy;->PROXY:Lcom/taobao/monitor/procedure/ProcedureManagerProxy;

    invoke-virtual {v0}, Lcom/taobao/monitor/procedure/ProcedureManagerProxy;->getLauncherProcedure()Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v0

    .line 45
    new-instance v1, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    invoke-direct {v1}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;-><init>()V

    const/4 v2, 0x0

    .line 46
    invoke-virtual {v1, v2}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setIndependent(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v1

    .line 47
    invoke-virtual {v1, v2}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setUpload(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v1

    .line 48
    invoke-virtual {v1, v2}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setParentNeedStats(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v1

    .line 49
    invoke-virtual {v1, v0}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setParent(Lcom/taobao/monitor/procedure/IProcedure;)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v0

    .line 50
    invoke-virtual {v0}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->build()Lcom/taobao/monitor/procedure/ProcedureConfig;

    move-result-object v0

    .line 52
    sget-object v1, Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;->PROXY:Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "/"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$1;->val$name:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;->createProcedure(Ljava/lang/String;Lcom/taobao/monitor/procedure/ProcedureConfig;)Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v0

    .line 53
    invoke-static {}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager;->access$100()Ljava/util/Map;

    move-result-object v1

    iget-object v2, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$1;->val$name:Ljava/lang/String;

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 55
    invoke-interface {v0}, Lcom/taobao/monitor/procedure/IProcedure;->begin()Lcom/taobao/monitor/procedure/IProcedure;

    const-string v1, "taskStart"

    iget-wide v2, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$1;->val$timeStamp:J

    .line 56
    invoke-interface {v0, v1, v2, v3}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    const-string v1, "cpuStartTime"

    iget-wide v2, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$1;->val$cpuStartTime:J

    .line 57
    invoke-interface {v0, v1, v2, v3}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    const-string v1, "threadName"

    iget-object v2, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$1;->val$threadName:Ljava/lang/String;

    .line 58
    invoke-interface {v0, v1, v2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-boolean v1, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$1;->val$isMainThread:Z

    .line 59
    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    const-string v2, "isMainThread"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    goto :goto_0

    .line 61
    :cond_0
    invoke-static {}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager;->access$200()Ljava/util/Map;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$1;->val$name:Ljava/lang/String;

    invoke-interface {v0, v1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    return-void

    .line 63
    :cond_1
    new-instance v0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;-><init>(Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$1;)V

    iget-wide v1, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$1;->val$timeStamp:J

    .line 64
    invoke-static {v0, v1, v2}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;->access$402(Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;J)J

    iget-wide v1, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$1;->val$cpuStartTime:J

    .line 65
    invoke-static {v0, v1, v2}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;->access$502(Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;J)J

    iget-boolean v1, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$1;->val$isMainThread:Z

    .line 66
    invoke-static {v0, v1}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;->access$602(Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;Z)Z

    iget-object v1, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$1;->val$threadName:Ljava/lang/String;

    .line 67
    invoke-static {v0, v1}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;->access$702(Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;Ljava/lang/String;)Ljava/lang/String;

    .line 68
    invoke-static {}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager;->access$200()Ljava/util/Map;

    move-result-object v1

    iget-object v2, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$1;->val$name:Ljava/lang/String;

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :goto_0
    return-void
.end method
