.class public Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager$InstanceCreater;
.super Ljava/lang/Object;
.source "ActivityNameManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "InstanceCreater"
.end annotation


# static fields
.field public static instance:Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager;


# direct methods
.method public static constructor <clinit>()V
    .locals 2

    .line 28
    new-instance v0, Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager;-><init>(Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager$1;)V

    sput-object v0, Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager$InstanceCreater;->instance:Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static synthetic access$100()Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager;
    .locals 1

    sget-object v0, Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager$InstanceCreater;->instance:Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager;

    return-object v0
.end method
