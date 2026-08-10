.class Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$2;
.super Ljava/lang/Object;
.source "TBAPMAdapterSubTaskManager.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager;->onEndTask(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$cpuEndTime:J

.field final synthetic val$name:Ljava/lang/String;

.field final synthetic val$timeStamp:J


# direct methods
.method constructor <init>(Ljava/lang/String;JJ)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x1010,
            0x1010,
            0x1010
        }
        names = {
            "val$name",
            "val$timeStamp",
            "val$cpuEndTime"
        }
    .end annotation

    iput-object p1, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$2;->val$name:Ljava/lang/String;

    iput-wide p2, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$2;->val$timeStamp:J

    iput-wide p4, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$2;->val$cpuEndTime:J

    .line 78
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .line 81
    invoke-static {}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager;->access$000()Z

    move-result v0

    if-nez v0, :cond_1

    .line 82
    invoke-static {}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager;->access$100()Ljava/util/Map;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$2;->val$name:Ljava/lang/String;

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/procedure/IProcedure;

    .line 84
    invoke-static {}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager;->access$200()Ljava/util/Map;

    move-result-object v1

    iget-object v2, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$2;->val$name:Ljava/lang/String;

    invoke-interface {v1, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;

    if-nez v0, :cond_0

    if-eqz v1, :cond_0

    .line 86
    sget-object v0, Lcom/taobao/monitor/procedure/ProcedureManagerProxy;->PROXY:Lcom/taobao/monitor/procedure/ProcedureManagerProxy;

    invoke-virtual {v0}, Lcom/taobao/monitor/procedure/ProcedureManagerProxy;->getLauncherProcedure()Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v0

    .line 87
    new-instance v2, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    invoke-direct {v2}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;-><init>()V

    const/4 v3, 0x0

    .line 88
    invoke-virtual {v2, v3}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setIndependent(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v2

    .line 89
    invoke-virtual {v2, v3}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setUpload(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v2

    .line 90
    invoke-virtual {v2, v3}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setParentNeedStats(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v2

    .line 91
    invoke-virtual {v2, v0}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setParent(Lcom/taobao/monitor/procedure/IProcedure;)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v0

    .line 92
    invoke-virtual {v0}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->build()Lcom/taobao/monitor/procedure/ProcedureConfig;

    move-result-object v0

    .line 94
    sget-object v2, Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;->PROXY:Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "/"

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v4, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$2;->val$name:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3, v0}, Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;->createProcedure(Ljava/lang/String;Lcom/taobao/monitor/procedure/ProcedureConfig;)Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v0

    .line 95
    invoke-interface {v0}, Lcom/taobao/monitor/procedure/IProcedure;->begin()Lcom/taobao/monitor/procedure/IProcedure;

    const-string v2, "taskStart"

    .line 96
    invoke-static {v1}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;->access$400(Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;)J

    move-result-wide v3

    invoke-interface {v0, v2, v3, v4}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    const-string v2, "cpuStartTime"

    .line 97
    invoke-static {v1}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;->access$500(Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;)J

    move-result-wide v3

    invoke-interface {v0, v2, v3, v4}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    .line 98
    invoke-static {v1}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;->access$600(Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;)Z

    move-result v2

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    const-string v3, "isMainThread"

    invoke-interface {v0, v3, v2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    const-string v2, "threadName"

    .line 99
    invoke-static {v1}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;->access$700(Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    .line 100
    invoke-static {}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager;->access$200()Ljava/util/Map;

    move-result-object v1

    iget-object v2, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$2;->val$name:Ljava/lang/String;

    invoke-interface {v1, v2}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    if-eqz v0, :cond_3

    const-string v1, "taskEnd"

    iget-wide v2, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$2;->val$timeStamp:J

    .line 104
    invoke-interface {v0, v1, v2, v3}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    const-string v1, "cpuEndTime"

    iget-wide v2, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$2;->val$cpuEndTime:J

    .line 105
    invoke-interface {v0, v1, v2, v3}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    .line 106
    invoke-interface {v0}, Lcom/taobao/monitor/procedure/IProcedure;->end()Lcom/taobao/monitor/procedure/IProcedure;

    .line 107
    invoke-static {}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager;->access$100()Ljava/util/Map;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$2;->val$name:Ljava/lang/String;

    invoke-interface {v0, v1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    .line 111
    :cond_1
    invoke-static {}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager;->access$200()Ljava/util/Map;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$2;->val$name:Ljava/lang/String;

    invoke-interface {v0, v1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    return-void

    .line 113
    :cond_2
    invoke-static {}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager;->access$200()Ljava/util/Map;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$2;->val$name:Ljava/lang/String;

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;

    iget-wide v1, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$2;->val$timeStamp:J

    .line 114
    invoke-static {v0, v1, v2}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;->access$802(Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;J)J

    iget-wide v1, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$2;->val$cpuEndTime:J

    .line 115
    invoke-static {v0, v1, v2}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;->access$902(Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;J)J

    :cond_3
    :goto_0
    return-void
.end method
