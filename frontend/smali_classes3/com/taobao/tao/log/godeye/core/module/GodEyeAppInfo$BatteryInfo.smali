.class public Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$BatteryInfo;
.super Ljava/lang/Object;
.source "GodEyeAppInfo.java"

# interfaces
.implements Ljava/io/Serializable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "BatteryInfo"
.end annotation


# instance fields
.field public batteryHealth:I

.field public batteryPercent:I

.field public batteryStatus:I

.field public batteryTemp:D

.field public batteryV:I


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 179
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
