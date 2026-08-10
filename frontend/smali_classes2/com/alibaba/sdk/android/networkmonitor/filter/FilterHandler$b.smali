.class Lcom/alibaba/sdk/android/networkmonitor/filter/FilterHandler$b;
.super Ljava/lang/Object;
.source "FilterHandler.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/alibaba/sdk/android/networkmonitor/filter/FilterHandler;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "b"
.end annotation


# static fields
.field private static a:Lcom/alibaba/sdk/android/networkmonitor/filter/FilterHandler;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 1
    new-instance v0, Lcom/alibaba/sdk/android/networkmonitor/filter/FilterHandler;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/filter/FilterHandler;-><init>(Lcom/alibaba/sdk/android/networkmonitor/filter/FilterHandler$a;)V

    sput-object v0, Lcom/alibaba/sdk/android/networkmonitor/filter/FilterHandler$b;->a:Lcom/alibaba/sdk/android/networkmonitor/filter/FilterHandler;

    return-void
.end method

.method static synthetic a()Lcom/alibaba/sdk/android/networkmonitor/filter/FilterHandler;
    .locals 1

    sget-object v0, Lcom/alibaba/sdk/android/networkmonitor/filter/FilterHandler$b;->a:Lcom/alibaba/sdk/android/networkmonitor/filter/FilterHandler;

    return-object v0
.end method
