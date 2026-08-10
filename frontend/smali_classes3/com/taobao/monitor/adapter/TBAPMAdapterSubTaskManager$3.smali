.class Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$3;
.super Ljava/lang/Object;
.source "TBAPMAdapterSubTaskManager.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager;->transferPendingTasks()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 122
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 8

    .line 125
    invoke-static {}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager;->access$200()Ljava/util/Map;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .line 126
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_1

    .line 127
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .line 128
    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 129
    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;

    .line 131
    invoke-static {v1}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;->access$800(Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;)J

    move-result-wide v4

    const-wide/16 v6, 0x0

    cmp-long v4, v4, v6

    if-nez v4, :cond_0

    goto :goto_0

    .line 135
    :cond_0
    sget-object v4, Lcom/taobao/monitor/procedure/ProcedureManagerProxy;->PROXY:Lcom/taobao/monitor/procedure/ProcedureManagerProxy;

    invoke-virtual {v4}, Lcom/taobao/monitor/procedure/ProcedureManagerProxy;->getLauncherProcedure()Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v4

    .line 136
    new-instance v5, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    invoke-direct {v5}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;-><init>()V

    .line 137
    invoke-virtual {v5, v2}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setIndependent(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v5

    .line 138
    invoke-virtual {v5, v2}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setUpload(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v5

    .line 139
    invoke-virtual {v5, v2}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setParentNeedStats(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v2

    .line 140
    invoke-virtual {v2, v4}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setParent(Lcom/taobao/monitor/procedure/IProcedure;)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v2

    .line 141
    invoke-virtual {v2}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->build()Lcom/taobao/monitor/procedure/ProcedureConfig;

    move-result-object v2

    .line 143
    sget-object v4, Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;->PROXY:Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;

    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "/"

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v4, v3, v2}, Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;->createProcedure(Ljava/lang/String;Lcom/taobao/monitor/procedure/ProcedureConfig;)Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v2

    .line 144
    invoke-interface {v2}, Lcom/taobao/monitor/procedure/IProcedure;->begin()Lcom/taobao/monitor/procedure/IProcedure;

    const-string v3, "taskStart"

    .line 145
    invoke-static {v1}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;->access$400(Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;)J

    move-result-wide v4

    invoke-interface {v2, v3, v4, v5}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    const-string v3, "cpuStartTime"

    .line 146
    invoke-static {v1}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;->access$500(Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;)J

    move-result-wide v4

    invoke-interface {v2, v3, v4, v5}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    .line 147
    invoke-static {v1}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;->access$600(Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;)Z

    move-result v3

    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    const-string v4, "isMainThread"

    invoke-interface {v2, v4, v3}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    const-string v3, "threadName"

    .line 148
    invoke-static {v1}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;->access$700(Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;)Ljava/lang/String;

    move-result-object v4

    invoke-interface {v2, v3, v4}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    const-string v3, "taskEnd"

    .line 149
    invoke-static {v1}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;->access$800(Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;)J

    move-result-wide v4

    invoke-interface {v2, v3, v4, v5}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    const-string v3, "cpuEndTime"

    .line 150
    invoke-static {v1}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;->access$900(Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;)J

    move-result-wide v4

    invoke-interface {v2, v3, v4, v5}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    .line 151
    invoke-interface {v2}, Lcom/taobao/monitor/procedure/IProcedure;->end()Lcom/taobao/monitor/procedure/IProcedure;

    .line 152
    invoke-interface {v0}, Ljava/util/Iterator;->remove()V

    goto/16 :goto_0

    .line 154
    :cond_1
    invoke-static {v2}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager;->access$002(Z)Z

    return-void
.end method
