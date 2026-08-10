.class public Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager;
.super Ljava/lang/Object;
.source "ActivityNameManager.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager$InstanceCreater;
    }
.end annotation


# instance fields
.field public activityListMaxLength:I

.field public activityNameList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 16
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager;->activityNameList:Ljava/util/List;

    const/16 v0, 0x14

    iput v0, p0, Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager;->activityListMaxLength:I

    return-void
.end method

.method public synthetic constructor <init>(Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager$1;)V
    .locals 0

    .line 13
    invoke-direct {p0}, Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager;-><init>()V

    return-void
.end method

.method public static getInstance()Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager;
    .locals 1

    .line 31
    invoke-static {}, Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager$InstanceCreater;->access$100()Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public addActivityName(Ljava/lang/String;)V
    .locals 2

    if-eqz p1, :cond_1

    :try_start_0
    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager;->activityNameList:Ljava/util/List;

    .line 41
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    iget v1, p0, Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager;->activityListMaxLength:I

    if-ge v0, v1, :cond_0

    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager;->activityNameList:Ljava/util/List;

    .line 42
    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager;->activityNameList:Ljava/util/List;

    const/4 v1, 0x0

    .line 44
    invoke-interface {v0, v1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager;->activityNameList:Ljava/util/List;

    .line 45
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    iget v1, p0, Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager;->activityListMaxLength:I

    if-ge v0, v1, :cond_1

    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager;->activityNameList:Ljava/util/List;

    .line 46
    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 51
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    :cond_1
    :goto_0
    return-void
.end method

.method public getActivityList()Ljava/lang/String;
    .locals 3

    .line 60
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v1, 0x0

    :goto_0
    :try_start_0
    iget-object v2, p0, Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager;->activityNameList:Ljava/util/List;

    .line 62
    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    if-ge v1, v2, :cond_1

    iget-object v2, p0, Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager;->activityNameList:Ljava/util/List;

    .line 63
    invoke-interface {v2, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 64
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager;->activityNameList:Ljava/util/List;

    .line 65
    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    add-int/lit8 v2, v2, -0x1

    if-ge v1, v2, :cond_0

    const-string v2, "+"

    .line 66
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :catch_0
    move-exception v1

    .line 70
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 72
    :cond_1
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getLastActivity()Ljava/lang/String;
    .locals 3

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager;->activityNameList:Ljava/util/List;

    .line 82
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    if-ltz v1, :cond_0

    iget-object v2, p0, Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager;->activityNameList:Ljava/util/List;

    .line 84
    invoke-interface {v2, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-object v0, v1

    goto :goto_0

    :catch_0
    move-exception v1

    .line 87
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    :cond_0
    :goto_0
    return-object v0
.end method
