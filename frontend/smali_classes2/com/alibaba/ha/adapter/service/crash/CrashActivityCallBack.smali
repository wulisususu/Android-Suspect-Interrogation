.class public Lcom/alibaba/ha/adapter/service/crash/CrashActivityCallBack;
.super Ljava/lang/Object;
.source "CrashActivityCallBack.java"

# interfaces
.implements Lcom/alibaba/ha/adapter/service/crash/JavaCrashListener;


# instance fields
.field public final activityListKey:Ljava/lang/String;

.field public final activityNameKey:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "_controller"

    iput-object v0, p0, Lcom/alibaba/ha/adapter/service/crash/CrashActivityCallBack;->activityNameKey:Ljava/lang/String;

    const-string v0, "_controllers"

    iput-object v0, p0, Lcom/alibaba/ha/adapter/service/crash/CrashActivityCallBack;->activityListKey:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public onCrashCaught(Ljava/lang/Thread;Ljava/lang/Throwable;)Ljava/util/Map;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Thread;",
            "Ljava/lang/Throwable;",
            ")",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    .line 29
    invoke-static {}, Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager;->getInstance()Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager;

    move-result-object p1

    invoke-virtual {p1}, Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager;->getLastActivity()Ljava/lang/String;

    move-result-object p1

    .line 30
    invoke-static {}, Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager;->getInstance()Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager;

    move-result-object p2

    invoke-virtual {p2}, Lcom/alibaba/ha/adapter/service/activity/ActivityNameManager;->getActivityList()Ljava/lang/String;

    move-result-object p2

    .line 32
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    if-eqz p1, :cond_0

    const-string v1, "_controller"

    .line 34
    invoke-interface {v0, v1, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    if-eqz p2, :cond_1

    const-string p1, "_controllers"

    .line 38
    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_1
    return-object v0
.end method
