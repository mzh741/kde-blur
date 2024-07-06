#!/bin/bash
declare -A blurred_windows  # 使用关联数组存储已模糊的窗口ID

while true; do
    sleep 0.5  # 减少CPU使用率
    declare -A current_windows  # 创建一个新数组来存储当前循环的窗口ID
    current_window_ids=$(wmctrl -l | cut -d " " -f 1)  # 获取当前所有窗口的ID

    for id in $current_window_ids; do
        current_windows[$id]=1  # 标记当前窗口为存在
        if [ -z "${blurred_windows[$id]}" ]; then  # 检查窗口ID是否未被记录
            xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id $id
            blurred_windows[$id]=1  # 记录已模糊的窗口ID
        fi
    done

    # 清除已关闭的窗口ID
    for id in "${!blurred_windows[@]}"; do
        if [ -z "${current_windows[$id]}" ]; then
            unset blurred_windows[$id]  # 如果窗口ID不在当前窗口列表中，从blurred_windows中移除
        fi
    done
done