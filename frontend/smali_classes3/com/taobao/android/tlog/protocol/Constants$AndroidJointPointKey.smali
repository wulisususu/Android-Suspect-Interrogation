.class public final Lcom/taobao/android/tlog/protocol/Constants$AndroidJointPointKey;
.super Ljava/lang/Object;
.source "Constants.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/android/tlog/protocol/Constants;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "AndroidJointPointKey"
.end annotation


# static fields
.field public static final EVENT_KEY_APP_STARTED:Ljava/lang/String; = "event.launchFinished"

.field public static final EVENT_KEY_PAGE_LOAD_FINISHED:Ljava/lang/String; = "event.pageLoadFinished"

.field public static final LIFECYCLE_KEY_ACTIVITY_CREATED:Ljava/lang/String; = "onActivityCreated"

.field public static final LIFECYCLE_KEY_ACTIVITY_DESTROYED:Ljava/lang/String; = "onActivityDestroyed"

.field public static final LIFECYCLE_KEY_ACTIVITY_PAUSED:Ljava/lang/String; = "onActivityPaused"

.field public static final LIFECYCLE_KEY_ACTIVITY_RESUMED:Ljava/lang/String; = "onActivityResumed"

.field public static final LIFECYCLE_KEY_ACTIVITY_SAVEINSTANCESTATE:Ljava/lang/String; = "onActivitySaveInstanceState"

.field public static final LIFECYCLE_KEY_ACTIVITY_STARTED:Ljava/lang/String; = "onActivityStarted"

.field public static final LIFECYCLE_KEY_ACTIVITY_STOPPED:Ljava/lang/String; = "onActivityStopped"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 63
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
